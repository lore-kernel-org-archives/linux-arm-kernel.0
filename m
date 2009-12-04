From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Dec 2009 12:45:05 +0000
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091204133943.ddf0e53d.ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<20091202180658.GA12292@rakim.wolfsonmicro.main>
	<20091204133943.ddf0e53d.ospite@studenti.unina.it>
Message-ID: <20091204124505.GA3320@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 01:39:43PM +0100, Antonio Ospite wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > You almost certainly want regulator_get_exclusive() here; this driver
> > can't function properly if something else is using the regulator and
> > holding the LED on or off without it.  You'll also want to check the
> > status of the LED on startup and update your internal status to match
> > that.

> When you refer to "the status of the LED on startup" do you mean a
> initial brightness value passed via leds-regulator platform data, or the
> initial status or the regulator itself?

The hardware state at startup; I would imagine that you'd want to make
setting the initial state via platform data optional in order to enable
a smooth handover from bootloader to Linux where the state may depend on
the runtime state (eg, charging indication).
