From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 11:58:56 -0600
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
In-Reply-To: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
References: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
Message-ID: <513F6CE0.2090600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 06:01 AM, Danny Huang wrote:
> Expose Tegra chip ID and revision in /sys/devices/soc for user mode
> usage

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index d1c4893..b7abcfa 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -17,6 +17,7 @@ config ARCH_TEGRA_2x_SOC
>  	select PINCTRL_TEGRA20
>  	select PL310_ERRATA_727915 if CACHE_L2X0
>  	select PL310_ERRATA_769419 if CACHE_L2X0
> +	select SOC_BUS
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select USB_ULPI if USB
>  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> @@ -36,6 +37,7 @@ config ARCH_TEGRA_3x_SOC
>  	select PINCTRL
>  	select PINCTRL_TEGRA30
>  	select PL310_ERRATA_769419 if CACHE_L2X0
> +	select SOC_BUS
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select USB_ULPI if USB
>  	select USB_ULPI_VIEWPORT if USB_SUPPORT
> @@ -51,6 +53,7 @@ config ARCH_TEGRA_114_SOC
>  	select CPU_V7
>  	select PINCTRL
>  	select PINCTRL_TEGRA114
> +	select SOC_BUS
>  	help

I assume we'll want this feature for all Tegra SoCs. Can't we select it
from ARCH_TEGRA, rather than separately for each chip? CONFIG_ARCH_TEGRA
is defined in arch/arm/Kconfig.
