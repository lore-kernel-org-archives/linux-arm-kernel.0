From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 09:24:08 +0200
Subject: [PATCH 12/16] ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx
	to mach-s5pc100
In-Reply-To: <001f01caf1a1$724c4470$56e4cd50$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-13-git-send-email-m.szyprowski@samsung.com>
	<001f01caf1a1$724c4470$56e4cd50$%kim@samsung.com>
Message-ID: <003001caf1a4$1e8629c0$5b927d40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 9:05 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Move sdhci helpers from plat-s5pc1xx to mach-s5pc100.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pc100/Kconfig                      |   11 +++++++++++
> >  arch/arm/mach-s5pc100/Makefile                     |    2 ++
> >  arch/arm/mach-s5pc100/cpu.c                        |    6 ++++++
> >  arch/arm/mach-s5pc100/include/mach/map.h           |    8 ++++++++
> >  .../setup-sdhci-gpio.c                             |    2 +-
> >  5 files changed, 28 insertions(+), 1 deletions(-)
> >  rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-sdhci-gpio.c (97%)
> >
> > diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-
> s5pc100/Kconfig
> > index f2d5c23..af64da3 100644
> > --- a/arch/arm/mach-s5pc100/Kconfig
> > +++ b/arch/arm/mach-s5pc100/Kconfig
> > @@ -24,6 +24,17 @@ config S5PC100_SETUP_I2C1
> >  	help
> >  	  Common setup code for i2c bus 1.
> >
> > +config S5PC100_SETUP_SDHCI
> > +        bool
> > +        select S5PC100_SETUP_SDHCI_GPIO
> > +        help
> > +          Internal helper functions for S5PC100 based SDHCI systems
> > +
> 
> Not aligned.
> Please fix it.

ok

> 
> > +config S5PC100_SETUP_SDHCI_GPIO
> > +	bool
> > +	help
> > +	  Common setup code for SDHCI gpio.
> > +
> >  config MACH_SMDKC100
> >  	bool "SMDKC100"
> >  	select CPU_S5PC100
> > diff --git a/arch/arm/mach-s5pc100/Makefile
> b/arch/arm/mach-s5pc100/Makefile
> > index 522d8b7..9242f14 100644
> > --- a/arch/arm/mach-s5pc100/Makefile
> > +++ b/arch/arm/mach-s5pc100/Makefile
> > @@ -18,6 +18,8 @@ obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
> >
> >  obj-$(CONFIG_S5PC100_SETUP_FB_24BPP) += setup-fb-24bpp.o
> >  obj-$(CONFIG_S5PC100_SETUP_I2C1) += setup-i2c1.o
> > +obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
> > +obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> 
> How about union the setup-sdhci-gpio.c to setup-sdhci file?
> I think don't need to separate setup-sdhci and setup-sdhci-gpio file.

I just followed the style of other Samsung machines (s3c64xx mainly).
If required I can merge these two files together.

> ...

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
