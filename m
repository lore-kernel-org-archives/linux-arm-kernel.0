From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 21:50:27 +0200
Subject: [PATCH 5/8] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <alpine.LFD.2.00.1105191542350.14430@xanadu.home>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110519180456.GA21172@pengutronix.de>
	<20110519190352.GS30963@pengutronix.de>
	<alpine.LFD.2.00.1105191542350.14430@xanadu.home>
Message-ID: <20110519195027.GU30963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 03:44:13PM -0400, Nicolas Pitre wrote:
> On Thu, 19 May 2011, Sascha Hauer wrote:
> 
> > On Thu, May 19, 2011 at 08:04:56PM +0200, Uwe Kleine-K?nig wrote:
> > > On Thu, May 19, 2011 at 06:47:25PM +0200, Sascha Hauer wrote:
> > > > index a5353fc..0202ca0 100644
> > > > --- a/arch/arm/plat-mxc/Kconfig
> > > > +++ b/arch/arm/plat-mxc/Kconfig
> > > > @@ -14,20 +14,12 @@ choice
> > > >  	prompt "Freescale CPU family:"
> > > >  	default ARCH_MX3
> > > >  
> > > > -config ARCH_MX1
> > > > -	bool "MX1-based"
> > > > +config ARCH_IMX_V4_V5
> > > > +	select ARM_PATCH_PHYS_VIRT
> > > > +	select AUTO_ZRELADDR
> > > select EXPERIMENTAL
> > 
> > Hm, yes. Though I would really prefer removing the depency on
> > EXPERIMENTAL.
> 
> If those features are actually used, relied upon, and therefore 
> obviously tested, I think the experimental dependency doesn't make sense 
> anymore.

I'll add a patch for this to this series.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
