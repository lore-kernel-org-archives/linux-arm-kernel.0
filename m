From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 14:03:35 +0000
Subject: [PATCH] ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
In-Reply-To: <20111130140150.GC711@S2100-06.ap.freescale.net>
References: <1322584345-19193-1-git-send-email-dave.martin@linaro.org>
 <20111130140150.GC711@S2100-06.ap.freescale.net>
Message-ID: <20111130140335.GC2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 10:01:51PM +0800, Shawn Guo wrote:
> On Tue, Nov 29, 2011 at 04:32:25PM +0000, Dave Martin wrote:
> [...]
> > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > index b3a1f2b..6871ed7 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -20,6 +20,7 @@ config ARCH_IMX_V6_V7
> >  	bool "i.MX3, i.MX6"
> >  	select AUTO_ZRELADDR if !ZBOOT_ROM
> >  	select ARM_PATCH_PHYS_VIRT
> > +	select HAVE_L2X0_L2CC
> >  	help
> >  	  This enables support for systems based on the Freescale i.MX3 and i.MX6
> >  	  family.
> > -- 
> 
> You may want to amend the following for above change.
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5f7f9c2..a134819 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -609,7 +609,6 @@ comment "i.MX6 family:"
>  config SOC_IMX6Q
>         bool "i.MX6 Quad support"
>         select ARM_GIC
> -       select CACHE_L2X0
>         select CPU_V7
>         select HAVE_ARM_SCU
>         select HAVE_IMX_GPC

Platforms where the L2x0 is considered compulsory should still select it
directly like this, instead of selecting HAVE_L2X0_L2CC.

Do you know whether it is OK to run mx6 with the L2 cache turned off?
(I would hope that it is OK... in which case we could make the change)

Cheers
---Dave
