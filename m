From: rpurdie@rpsys.net (Richard Purdie)
Date: Wed, 26 May 2010 12:44:10 +0100
Subject: [PATCH 5/5] leds-gpio: Change blink_set callback to be able to
	turn off blinking
In-Reply-To: <1274872808.1931.310.camel@pasglop>
References: <1274525695.1931.143.camel@pasglop>
	<1274871937.16229.79.camel@rex>  <1274872808.1931.310.camel@pasglop>
Message-ID: <1274874250.16229.87.camel@rex>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-26 at 21:20 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-05-26 at 12:05 +0100, Richard Purdie wrote:
> > On Sat, 2010-05-22 at 20:54 +1000, Benjamin Herrenschmidt wrote:
> > > The leds-gpio blink_set() callback follows the same prototype as the
> > > main leds subsystem blink_set() one.
> > > 
> > > The problem is that to stop blink, normally, a leds driver does it
> > > in the brightness_set() callback when asked to set a new fixed value.
> > > 
> > > However, with leds-gpio, the platform has no hook to do so, as this
> > > later callback results in a standard GPIO manipulation.
> > > 
> > > This changes the leds-gpio specific callback to take a new argument
> > > that indicates whether the LED should be blinking or not and in what
> > > state it should be set if not. We also update the dns323 platform
> > > which seems to be the only user of this so far.
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > CC: Richard Purdie <rpurdie@rpsys.net>
> > > CC: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >  arch/arm/mach-orion5x/dns323-setup.c |   23 +++++++++++++----------
> > >  drivers/leds/leds-gpio.c             |   31 ++++++++++++++++++++++++-------
> > >  include/linux/leds.h                 |   12 ++++++++----
> > >  3 files changed, 45 insertions(+), 21 deletions(-)
> > 
> > Queued in the leds tree, thanks.
> 
> You may need to fixup the dns323 bit if you apply before my dns323 rev C
> patches ... but I suppose you figured that out already ;-) It should be
> minor.

Yes, I noticed just after I hit send and applied. I'd rather get the
core change in sooner than later and the reject doesn't look serious so
I'm assuming you can fix up the missing active_low bit for the new
addition easily enough?

Cheers,

Richard
