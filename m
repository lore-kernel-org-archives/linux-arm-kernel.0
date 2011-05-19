From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 May 2011 15:44:13 -0400 (EDT)
Subject: [PATCH 5/8] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <20110519190352.GS30963@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110519180456.GA21172@pengutronix.de>
	<20110519190352.GS30963@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1105191542350.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2011, Sascha Hauer wrote:

> On Thu, May 19, 2011 at 08:04:56PM +0200, Uwe Kleine-K?nig wrote:
> > On Thu, May 19, 2011 at 06:47:25PM +0200, Sascha Hauer wrote:
> > > index a5353fc..0202ca0 100644
> > > --- a/arch/arm/plat-mxc/Kconfig
> > > +++ b/arch/arm/plat-mxc/Kconfig
> > > @@ -14,20 +14,12 @@ choice
> > >  	prompt "Freescale CPU family:"
> > >  	default ARCH_MX3
> > >  
> > > -config ARCH_MX1
> > > -	bool "MX1-based"
> > > +config ARCH_IMX_V4_V5
> > > +	select ARM_PATCH_PHYS_VIRT
> > > +	select AUTO_ZRELADDR
> > select EXPERIMENTAL
> 
> Hm, yes. Though I would really prefer removing the depency on
> EXPERIMENTAL.

If those features are actually used, relied upon, and therefore 
obviously tested, I think the experimental dependency doesn't make sense 
anymore.


Nicolas
