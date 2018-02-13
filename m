From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Feb 2018 16:43:11 +0100
Subject: [PATCH 01/20] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
In-Reply-To: <20180205012146.23981-2-ulfalizer@gmail.com> (Ulf Magnusson's
 message of "Mon, 5 Feb 2018 02:21:13 +0100")
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-2-ulfalizer@gmail.com>
Message-ID: <87lgfwq4j4.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,
 
 On lun., f?vr. 05 2018, Ulf Magnusson <ulfalizer@gmail.com> wrote:

> The MACH_ARMADA_375 and MACH_ARMADA_38X boards select ARM_ERRATA_753970,
> but it was renamed to PL310_ERRATA_753970 by commit fa0ce4035d48 ("ARM:
> 7162/1: errata: tidy up Kconfig options for PL310 errata workarounds").
>
> Fix the selects to use the new name.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.

Applied on mvebu/fixes with the "Fixes": and "CC:stable" flags

Thanks,

Gregory

>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 6b32dc527edc..2c20599cc350 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -41,7 +41,7 @@ config MACH_ARMADA_375
>  	depends on ARCH_MULTI_V7
>  	select ARMADA_370_XP_IRQ
>  	select ARM_ERRATA_720789
> -	select ARM_ERRATA_753970
> +	select PL310_ERRATA_753970
>  	select ARM_GIC
>  	select ARMADA_375_CLK
>  	select HAVE_ARM_SCU
> @@ -57,7 +57,7 @@ config MACH_ARMADA_38X
>  	bool "Marvell Armada 380/385 boards"
>  	depends on ARCH_MULTI_V7
>  	select ARM_ERRATA_720789
> -	select ARM_ERRATA_753970
> +	select PL310_ERRATA_753970
>  	select ARM_GIC
>  	select ARM_GLOBAL_TIMER
>  	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> -- 
> 2.14.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
