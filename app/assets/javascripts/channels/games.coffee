 App.games = App.cable.subscriptions.create "GamesChannel",
  connected: ->
    if gameId = $("[data-channel='games']").data('game-id')
      @perform "follow", game_id: gameId
    else
      @perform "unfollow"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    debugger;
    if summary = data['summary']
      $('#home-team-runs').text(summary['home_team']['runs'])
      $('#home-team-hits').text(summary['home_team']['hits'])
      $('#home-team-errors').text(summary['home_team']['errors'])
      $('#away-team-runs').text(summary['away_team']['runs'])
      $('#away-team-hits').text(summary['away_team']['hits'])
      $('#away-team-errors').text(summary['home_team']['errors'])
    if innings = data['innings']
      innings.forEach (inning) =>
        $("#inning-#{inning['number']}-home").text(inning['home']['runs'])
        $("#inning-#{inning['number']}-away").text(inning['away']['runs'])

    # Called when there's incoming data on the websocket for this channel

  update: (data)->
    @perform 'update', data
