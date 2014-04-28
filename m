From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 20:07:38 +0200
Subject: [PATCH 1/2] ARM: sunxi: Split the various SoCs support in Kconfig
In-Reply-To: <1398529014-1152-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398529014-1152-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398529014-1152-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <8970285.5xeG1588Q7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 April 2014 18:16:53 Maxime Ripard wrote:
> This will allow to better isolate various options, and reduce the overall
> kernel size if we're interested in only one of the SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Looks good, just one small request:


> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b57d7d53b9d3..23575010ff49 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,14 +1,37 @@
>  config ARCH_SUNXI
> -       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> -       select ARCH_HAS_RESET_CONTROLLER
> +       bool "Allwinner SoCs" if ARCH_MULTI_V7
>         select ARCH_REQUIRE_GPIOLIB
> -       select ARM_GIC
> -       select ARM_PSCI
>         select CLKSRC_MMIO
>         select GENERIC_IRQ_CHIP
> -       select HAVE_ARM_ARCH_TIMER
>         select PINCTRL
>         select PINCTRL_SUNXI
> -       select RESET_CONTROLLER
>         select SUN4I_TIMER

Please make this 'menuconfig' instead of 'config', so it shows up as
only one line in the main menu. I would like to do this for all platforms
that have sub-options eventually.

	Arnd
