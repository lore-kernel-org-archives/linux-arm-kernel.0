From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Wed, 30 Jan 2013 10:44:39 +0530
Subject: [PATCH v2 3/5] ARM: make the platforms not to select the l2x0
 erratas
In-Reply-To: <5107DD5C.9020203@gmail.com>
References: <20130129101537.GA19817@bnru10>
 <5107DD5C.9020203@gmail.com>
Message-ID: <20130130051438.GA8735@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 15:31:56 +0100, Rob Herring wrote:
> On 01/29/2013 04:15 AM, srinidhi kasagar wrote:
> > Make the platforms not to choose the Errata's explicitly
> 
> Why?

Because I have two platforms where one suffers from a Errata whereas other
do not, but shares the same defconfig. Basically, I wanted to avoid 
choosing these Errata's during build time and tried to make the decisions
at run time rather...but, that looks like it's not going in the right 
direction..let me rework on the series.

Thanks,srinidhi
> 
> > 
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > ---
> >  arch/arm/mach-imx/Kconfig      |    3 ---
> >  arch/arm/mach-omap2/Kconfig    |    2 --
> >  arch/arm/mach-tegra/Kconfig    |    3 ---
> >  arch/arm/mach-ux500/Kconfig    |    1 -
> >  arch/arm/mach-vexpress/Kconfig |    1 -
> >  5 files changed, 0 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 3e628fd..8ed6672 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -855,9 +855,6 @@ config SOC_IMX6Q
> >  	select MFD_SYSCON
> >  	select PINCTRL
> >  	select PINCTRL_IMX6Q
> > -	select PL310_ERRATA_588369 if CACHE_PL310
> > -	select PL310_ERRATA_727915 if CACHE_PL310
> > -	select PL310_ERRATA_769419 if CACHE_PL310
> >  	select PM_OPP if PM
> >  
> >  	help
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 41b581f..7612c07 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -67,8 +67,6 @@ config ARCH_OMAP4
> >  	select HAVE_SMP
> >  	select LOCAL_TIMERS if SMP
> >  	select OMAP_INTERCONNECT
> > -	select PL310_ERRATA_588369
> > -	select PL310_ERRATA_727915
> >  	select PM_OPP if PM
> >  	select PM_RUNTIME if CPU_IDLE
> >  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> > index b442f15..f6214f5 100644
> > --- a/arch/arm/mach-tegra/Kconfig
> > +++ b/arch/arm/mach-tegra/Kconfig
> > @@ -15,8 +15,6 @@ config ARCH_TEGRA_2x_SOC
> >  	select CPU_V7
> >  	select PINCTRL
> >  	select PINCTRL_TEGRA20
> > -	select PL310_ERRATA_727915 if CACHE_L2X0
> > -	select PL310_ERRATA_769419 if CACHE_L2X0
> >  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> >  	select USB_ULPI if USB
> >  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> > @@ -36,7 +34,6 @@ config ARCH_TEGRA_3x_SOC
> >  	select CPU_V7
> >  	select PINCTRL
> >  	select PINCTRL_TEGRA30
> > -	select PL310_ERRATA_769419 if CACHE_L2X0
> >  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
> >  	select USB_ULPI if USB
> >  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> > diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> > index 5dea906..db13db5 100644
> > --- a/arch/arm/mach-ux500/Kconfig
> > +++ b/arch/arm/mach-ux500/Kconfig
> > @@ -11,7 +11,6 @@ config UX500_SOC_COMMON
> >  	select COMMON_CLK
> >  	select PINCTRL
> >  	select PINCTRL_NOMADIK
> > -	select PL310_ERRATA_753970 if CACHE_PL310
> >  
> >  config UX500_SOC_DB8500
> >  	bool
> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 52d315b..c658c40 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -42,7 +42,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> >  	bool "Enable A5 and A9 only errata work-arounds"
> >  	default y
> >  	select ARM_ERRATA_720789
> > -	select PL310_ERRATA_753970 if CACHE_PL310
> >  	help
> >  	  Provides common dependencies for Versatile Express platforms
> >  	  based on Cortex-A5 and Cortex-A9 processors. In order to
> > 
> 
