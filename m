From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Dec 2015 12:24:43 +0100
Subject: [PATCH 4/4] ARM: mvebu: use the ARMADA_370_XP_IRQ option
In-Reply-To: <1450707546-15060-5-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Mon, 21 Dec 2015 15:19:06 +0100")
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87wps5e7b8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

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

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index e20fc41..d071080 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -2,7 +2,6 @@ menuconfig ARCH_MVEBU
>  	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select CLKSRC_MMIO
> -	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select PLAT_ORION
>  	select SOC_BUS
> @@ -27,6 +26,7 @@ config MACH_MVEBU_V7
>  config MACH_ARMADA_370
>  	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
>  	select ARMADA_370_CLK
> +	select ARMADA_370_XP_IRQ
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7
>  	select PINCTRL_ARMADA_370
> @@ -36,6 +36,7 @@ config MACH_ARMADA_370
>  
>  config MACH_ARMADA_375
>  	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
> +	select ARMADA_370_XP_IRQ
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> @@ -54,6 +55,7 @@ config MACH_ARMADA_38X
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> +	select ARMADA_370_XP_IRQ
>  	select ARMADA_38X_CLK
>  	select HAVE_ARM_SCU
>  	select HAVE_ARM_TWD if SMP
> @@ -67,6 +69,7 @@ config MACH_ARMADA_38X
>  config MACH_ARMADA_39X
>  	bool "Marvell Armada 39x boards" if ARCH_MULTI_V7
>  	select ARM_GIC
> +	select ARMADA_370_XP_IRQ
>  	select ARMADA_39X_CLK
>  	select CACHE_L2X0
>  	select HAVE_ARM_SCU
> @@ -80,6 +83,7 @@ config MACH_ARMADA_39X
>  
>  config MACH_ARMADA_XP
>  	bool "Marvell Armada XP boards" if ARCH_MULTI_V7
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
