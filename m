From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jan 2016 14:28:52 +0100
Subject: [PATCH v2 6/6] ARM: mvebu: use the ARMADA_370_XP_IRQ option
In-Reply-To: <1453899395-3532-7-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 27 Jan 2016 13:56:35 +0100")
References: <1453899395-3532-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453899395-3532-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87lh7b9mnf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., janv. 27 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Now that there is a ARMADA_370_XP_IRQ option to enable the irqchip
> driver for Armada 370, XP, 375, 38x and 39x, let's select this option
> when needed. Note that this selection is currently not mandatory
> because ARMADA_370_XP_IRQ is for now always enabled when ARCH_MVEBU=y,
> but this is something that we will change in the future, and therefore
> we should make the relevant platforms select ARMADA_370_XP_IRQ when
> needed.
>
> Due to this, selecting GENERIC_IRQ_CHIP is no longer needed.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This patch can also be merged through the irqchip tree to be sure that
will be merged after the 2st patch whiwh select GENERIC_IRQ_CHIP when
ARMADA_370_XP_IRQ is selected.

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 64e3d2c..b003e3a 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -3,7 +3,6 @@ menuconfig ARCH_MVEBU
>  	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select CLKSRC_MMIO
> -	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select PLAT_ORION
>  	select SOC_BUS
> @@ -29,6 +28,7 @@ config MACH_ARMADA_370
>  	bool "Marvell Armada 370 boards"
>  	depends on ARCH_MULTI_V7
>  	select ARMADA_370_CLK
> +	select ARMADA_370_XP_IRQ
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7
>  	select PINCTRL_ARMADA_370
> @@ -39,6 +39,7 @@ config MACH_ARMADA_370
>  config MACH_ARMADA_375
>  	bool "Marvell Armada 375 boards"
>  	depends on ARCH_MULTI_V7
> +	select ARMADA_370_XP_IRQ
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> @@ -58,6 +59,7 @@ config MACH_ARMADA_38X
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> +	select ARMADA_370_XP_IRQ
>  	select ARMADA_38X_CLK
>  	select HAVE_ARM_SCU
>  	select HAVE_ARM_TWD if SMP
> @@ -72,6 +74,7 @@ config MACH_ARMADA_39X
>  	bool "Marvell Armada 39x boards"
>  	depends on ARCH_MULTI_V7
>  	select ARM_GIC
> +	select ARMADA_370_XP_IRQ
>  	select ARMADA_39X_CLK
>  	select CACHE_L2X0
>  	select HAVE_ARM_SCU
> @@ -86,6 +89,7 @@ config MACH_ARMADA_39X
>  config MACH_ARMADA_XP
>  	bool "Marvell Armada XP boards"
>  	depends on ARCH_MULTI_V7
> +	select ARMADA_370_XP_IRQ
>  	select ARMADA_XP_CLK
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7
> -- 
> 2.6.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
