exec = require('child_process').exec
process = require('process')
path = require('path')
fs = require('fs')

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'open-in-cmder:open', => @open_in_cmd()
    atom.commands.add '.tree-view .selected', 'open-in-cmder:open_path' : (event) => @open_in_cmder(event.currentTarget)

  open_in_cmder: (target) ->
    if target?
      select_file = target.getPath?() ? target.item?.getPath() ? target
    else
      select_file = atom.workspace.getActivePaneItem()?.buffer?.file?.getPath()
      select_file ?= atom.project.getPaths()?[0]

    if select_file? and fs.lstatSync(select_file).isFile()
      dir_path = path.dirname(select_file)
    else
      dir_path = select_file

    exec "start cmder /START \"#{dir_path}\""
