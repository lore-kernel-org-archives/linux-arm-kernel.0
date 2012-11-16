From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Nov 2012 15:19:57 +0100
Subject: [PATCH 2/4] ARM: imx: add imx5x usbmisc clock lookups
In-Reply-To: <20121116142846.GI2941@S2100-06.ap.freescale.net>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352988014-14769-3-git-send-email-m.grzeschik@pengutronix.de>
 <20121116092515.GM10369@pengutronix.de>
 <20121116142846.GI2941@S2100-06.ap.freescale.net>
Message-ID: <20121116141957.GT10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:28:48PM +0800, Shawn Guo wrote:
> On Fri, Nov 16, 2012 at 10:25:15AM +0100, Sascha Hauer wrote:
> > On Thu, Nov 15, 2012 at 03:00:12PM +0100, Michael Grzeschik wrote:
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > ---
> > >  arch/arm/mach-imx/clk-imx51-imx53.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> > > index 3edd11c..33c3c9b 100644
> > > --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> > > +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> > > @@ -365,6 +365,9 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
> > >  	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80000.usb");
> > >  	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80000.usb");
> > >  	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80000.usb");
> > > +	clk_register_clkdev(clk[usboh3_per_gate], "per", "73f80800.usbmisc");
> > > +	clk_register_clkdev(clk[usboh3_gate], "ipg", "73f80800.usbmisc");
> > > +	clk_register_clkdev(clk[usboh3_gate], "ahb", "73f80800.usbmisc");
> > 
> > Shawn, do you have plans to move the clock lookups to devicetree like
> > you did on i.MX6? It would be nice to get rid of patches like this.
> > 
> Right.  But I will not be able to resume the IMX cleanup work like this
> any soon, as I have some FSL internal stuff to sort out.  So please go
> ahead to do it.

I didn't have the intention to volunteer for this job ;)
Anyway, I'll see if I find time for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
