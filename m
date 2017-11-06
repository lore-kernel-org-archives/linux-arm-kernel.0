From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 6 Nov 2017 19:20:41 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171106073246.efcz7r2vnymz3me7@pengutronix.de>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
 <20171106073246.efcz7r2vnymz3me7@pengutronix.de>
Message-ID: <1509996041.5473.103.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-11-06 at 08:32 +0100, Sascha Hauer wrote:
> On Fri, Nov 03, 2017 at 07:18:56PM +0000, Trent Piepho wrote:
> > 
> > Comments in the driver indicate that some SoCs do not allow GPIO usage
> > on all chip select pins.
> 
> Which comments do you mean? I remember there were comments, but I can't
> find any in the driver.

It's in arch/arm/plat-mxc/include/mach/spi.h.

> The only SoC which has dedicated SPI CS pins which can't be configured
> as GPIOs is the i.MX31. Unless you have an i.MX31 you shouldn't be
> forced to use native chip selects.

Indeed I'm not forced to, but native is more efficient and faster, and
since I'm lucky enough that they work for me, I'd like to be able to
use them.  And I can already, but the DT bindings are non-standard and
I don't see any value in that. DT bindings are complex enough without
drivers adding quirks. And my experience was no one connected the non-
standard bindings with native CS not working well.  I think explicit
documentation will be more effective at that.
