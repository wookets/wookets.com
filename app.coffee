express = require 'express'

GLOBAL.app = module.exports = app = express() # module.exports allows this app to work in a cluster with other apps

app.configure ->
  app.use express.favicon() # make sure we can serve up a favicon
  app.use express.logger({format: 'tiny'}) # log express routing things (includes profiling)
  app.use express.bodyParser() # express will parse http POST, etc for us
  app.use express.cookieParser()
  app.use express.session {secret: "paw wookets"} # let express maintain session thread tracking for us 
  app.use app.router
  app.use express.static("./public") # if a static file is request (i.e. index.html) look in this folder
  
app.configure "development", ->
  app.use express.errorHandler({dumpExceptions: true, showStack: true})
  
app.configure "production", ->
  app.use express.errorHandler()

appServer = app.listen(process.env.PORT or 3000) # auto set port for heroku
console.log "Express server listening on port #{appServer.address().port} in #{app.settings.env} mode"


    