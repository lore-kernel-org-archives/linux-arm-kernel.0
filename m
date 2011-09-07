From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2011 09:26:22 +0200
Subject: [PATCH 5/6] arm/imx6q: add device tree machine support
In-Reply-To: <20110907030733.GC8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<26851240.8fI4nVmxXO@wuerfel>
	<20110907030733.GC8148@S2100-06.ap.freescale.net>
Message-ID: <1722629.tAO8hTTLHc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011 11:07:34 Shawn Guo wrote:
> On Tue, Sep 06, 2011 at 08:55:45PM +0200, Arnd Bergmann wrote:
> > On Tuesday 06 September 2011 17:58:39 Shawn Guo wrote:
> > 
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 13e0301..3364b59 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -624,3 +624,16 @@ config MACH_VPR200
> > >       configurations for the board and its peripherals.
> > >  
> > >  endif
> > > +
> > > +if ARCH_MX6
> > > +comment "i.MX6 machines:"
> > > +
> > > +config MACH_IMX6Q
> > > +   bool "Support i.MX6 Quad platforms from device tree"
> > > +   select SOC_IMX6Q
> > > +   select USE_OF
> > > +   help
> > > +     Include support for Freescale i.MX6 Quad based platforms
> > > +     using the device tree for discovery
> > > +
> > > +endif
> > 
> > As we have done on zynq and prima2, I would suggest not to add multiple
> > machines types at all. You already have the intialization in a generic
> > imx6q file, it would be logical to get rid of the configuration entry
> > as well.
> > 
> This MACH_IMX6Q was added to make the IMX6Q Kconfig hierarchy look
> consistent with other SoCs in arch/arm/mach-imx/Kconfig.  If you
> do not like it, I can kill it.

Yes, plase do. I think we should in the long run get more platforms
to do the same, it will be a sign that mx6 is part of the new generation.

	Arnd
