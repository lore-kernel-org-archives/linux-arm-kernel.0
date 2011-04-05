From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 09:43:48 +0100
Subject: [PATCH v2 1/2] ARM: mxc: Introduce imx_add_gpio_leds
In-Reply-To: <20110405083259.GO13963@pengutronix.de>
References: <0D753D10438DA54287A00B027084269764D1C13BB8@AUSP01VMBX24.collaborationhost.net>
	<20110404181759.GG22480@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D1C89CC6@AUSP01VMBX24.collaborationhost.net>
	<20110405073030.GI13963@pengutronix.de>
	<20110405074017.GA4633@n2100.arm.linux.org.uk>
	<20110405074315.GL13963@pengutronix.de>
	<20110405074754.GB4633@n2100.arm.linux.org.uk>
	<20110405075118.GM13963@pengutronix.de>
	<20110405075932.GC4633@n2100.arm.linux.org.uk>
	<20110405083259.GO13963@pengutronix.de>
Message-ID: <20110405084348.GD4633@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 10:32:59AM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Apr 05, 2011 at 08:59:32AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 05, 2011 at 09:51:18AM +0200, Uwe Kleine-K?nig wrote:
> > > This was intended by
> > > 
> > > 	struct gpio_led_platform_data *_pdata = *pdata;
> > > 
> > > I'm just fighting with the compiler at this line because it doesn't like
> > > _pdata being initialized by a const pointer.
> > 
> > That's idiotic and revolting.  Casting away const means you're writing
> > broken code, which can fail for XIP users.  If you're going to play
> > such games, there's *NO* point in marking it const in the first place.
> No I won the fight with the compiler, the result is
> 
> 	struct gpio_led_platform_data _pdata = *pdata
> 
> which AFAIK is valid C and even works for XIP users.

Which will work, but that's not what you wrote in the first two posts
of the code.
