From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 29 Jan 2015 15:27:40 +0100
Subject: [PATCH v2] MediaTek PMIC support
In-Reply-To: <CABuKBe+x9o5OiysnMq-gvOBx3nKoaheL2efZGA6YQ7ZT5aqijw@mail.gmail.com>
References: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
 <20150126114735.GA3178@pengutronix.de>
 <CABuKBe+x9o5OiysnMq-gvOBx3nKoaheL2efZGA6YQ7ZT5aqijw@mail.gmail.com>
Message-ID: <20150129142740.GH12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 01:39:42PM +0100, Matthias Brugger wrote:
> Hi Sascha,
> 
> 2015-01-26 12:47 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > Olof, Arnd,
> >
> > OK to put the driver into drivers/soc/mediatek? Can you take these
> > patches?
> 
> How does this patches fit together with the one James clock framework patches?
> Both use the same compatible "mediatek,mt8135-infracfg" and
> "mediatek,mt8135-pericfg".
> 
> I had a look on other implementations and they attach the reset
> controller to the clk driver, if they share the same hw block.
> Might we run into problems if we implement the clocks in the mfd, as
> we need the clocks early in boot (e.g. for the timer)?

>From my experience the clocks are needed by the timer before any driver
initializes.

> 
> In mt6589 pericfg apart from the clocks and reset controller provides
> registers for AXI bus control and USB wakeup and USB clock selection.
> The infracfg block provides top AXI bus fabric control signals and
> remap registers for the modem.
> Mike, Stephen, what do you think. Can we implement the clk in a mfd
> driver? Or do you prefer to implement the whole block in the clk
> driver?

Currently the clk support uses regular CLK_OF_DECLARE which handles the
clock part of pericfg/infracfg and then later a regular driver for
pericfg/infracfg comes and handles the rest of the functionality. Since
both use separate registers in the device register space it should work
fine.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
