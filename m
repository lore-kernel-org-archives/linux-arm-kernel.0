From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Nov 2017 08:32:46 +0100
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <1509736735.5473.87.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
Message-ID: <20171106073246.efcz7r2vnymz3me7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 07:18:56PM +0000, Trent Piepho wrote:
> On Fri, 2017-11-03 at 18:37 +0000, Mark Brown wrote:
> > On Fri, Nov 03, 2017 at 05:53:59PM +0000, Trent Piepho wrote:
> > 
> > > Just to be clear, one doesn't need to use GPIOs with the driver as is. 
> > > But the bindings to do that are non-standard and these patches make the
> > > driver follow the standard. (and don't break anyone).
> > 
> > If there are non-standard bindings then mark them as deprecated.  I
> > can't immediately find *any* binding documentation for this controller.
> > The last commit looks like it was more attempting to work round broken
> > board bindings and do something sensible than add a new binding, at
> > least that's what I remember my sense of it being.
> 
> The non-standard part is needing to add cs-gpios = <0> to get a native
> chip select when that is documented as being optional.  It doesn't
> follow the spec.  It doesn't match other drivers (and dw-spi is equally
> as broken in the same manner, probably others too) that do follow the
> spec.
> 
> > If the hardware is as broken as these controllers always were in the
> > past and there are workarounds which work in all practical situations
> > (AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)
> 
> Comments in the driver indicate that some SoCs do not allow GPIO usage
> on all chip select pins.

Which comments do you mean? I remember there were comments, but I can't
find any in the driver.

The only SoC which has dedicated SPI CS pins which can't be configured
as GPIOs is the i.MX31. Unless you have an i.MX31 you shouldn't be
forced to use native chip selects.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
