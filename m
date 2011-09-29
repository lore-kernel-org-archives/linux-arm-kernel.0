From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 29 Sep 2011 10:35:13 +0200
Subject: [PATCH 6/6] arm/imx: merge i.MX3 and i.MX6
In-Reply-To: <20110929051725.GA19318@S2100-06.ap.freescale.net>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
	<1317201368-6403-7-git-send-email-shawn.guo@linaro.org>
	<20110928121808.GY31404@pengutronix.de>
	<20110929051725.GA19318@S2100-06.ap.freescale.net>
Message-ID: <20110929083512.GC31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 01:17:28PM +0800, Shawn Guo wrote:
> On Wed, Sep 28, 2011 at 02:18:08PM +0200, Sascha Hauer wrote:
> > On Wed, Sep 28, 2011 at 05:16:08PM +0800, Shawn Guo wrote:
> > > 
> > >  
> > > -config ARCH_MX3
> > > -	bool "MX3-based"
> > > +config ARCH_IMX_V6_V7
> > > +	bool "i.MX3, i.MX6"
> > > +	select AUTO_ZRELADDR
> > > +	select ARM_PATCH_PHYS_VIRT
> > 
> > Russell pointed out that it's not a good idea to select this.
> > 
> Yeah, I saw that.  So you would support ZBOOT_ROM over single zImage
> between these two?  I'm not sure how many imx users are actually using
> ZBOOT_ROM.  If there are only very few, we still want to keep the
> default configuration compatible with ZBOOT_ROM?  I think we can move
> the default build to single zImage, and let those limited users sort
> out their own configuration to get ZBOOT_ROM back.  After all, the
> support is still there, and it's just about build configuration
> adjustment.

I'm not sure there are i.MX ZBOOT_ROM users at all. Anyway,

	select AUTO_ZRELADDR if !ZBOOT_ROM

seems to work.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
