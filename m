From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jul 2012 09:12:48 +0200
Subject: [PATCH] ARM: imx: select IRQ_DOMAIN
In-Reply-To: <20120706070458.GA22129@S2101-09.ap.freescale.net>
References: <20120614071326.GC31565@S2101-09.ap.freescale.net>
 <1341555995-22532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120706070458.GA22129@S2101-09.ap.freescale.net>
Message-ID: <20120706071247.GC30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 03:05:01PM +0800, Shawn Guo wrote:
> On Fri, Jul 06, 2012 at 08:26:34AM +0200, Uwe Kleine-K?nig wrote:
> > ---
> >  arch/arm/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 84449dd..38b6b90 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -446,6 +446,7 @@ config ARCH_MXC
> >  	select CLKSRC_MMIO
> >  	select GENERIC_IRQ_CHIP
> >  	select MULTI_IRQ_HANDLER
> > +	select IRQ_DOMAIN
> 
> Right, I forgot that we haven't selected USE_OF for ARCH_MXC.  Can we
> do that instead of selecting IRQ_DOMAIN, since we are on the way to
> device tree?  Selecting USE_OF will save us a lot of #ifdef CONFIG_OF
> checks later when we add device tree support into more codes.

Fine with me.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
