From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 20 Feb 2014 10:56:57 +0530
Subject: [Patch v3 18/23] drivers: Enable building of Kirkwood drivers
 for mach-mvebu
In-Reply-To: <1392819174-11634-19-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392819174-11634-19-git-send-email-andrew@lunn.ch>
Message-ID: <53059221.9060709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 February 2014 07:42 PM, Andrew Lunn wrote:
> With the move of kirkwood into mach-mvebu, drivers Kconfig need
> tweeking to allow the kirkwood specific drivers to be built.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> v2

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> Simplify cpufreq/Kconfig.arm
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  drivers/cpuidle/Kconfig.arm | 2 +-
>  drivers/leds/Kconfig        | 4 ++--
>  drivers/phy/Kconfig         | 2 +-
>  drivers/thermal/Kconfig     | 2 +-
>  sound/soc/kirkwood/Kconfig  | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 31297499a60a..077db3aa985b 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -113,7 +113,7 @@ config ARM_INTEGRATOR
>  	  If in doubt, say Y.
>  
>  config ARM_KIRKWOOD_CPUFREQ
> -	def_bool ARCH_KIRKWOOD && OF
> +	def_bool MACH_KIRKWOOD
>  	help
>  	  This adds the CPUFreq driver for Marvell Kirkwood
>  	  SoCs.
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index d988948a89a0..97ccc31dbdd8 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -22,7 +22,7 @@ config ARM_HIGHBANK_CPUIDLE
>  
>  config ARM_KIRKWOOD_CPUIDLE
>  	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> -	depends on ARCH_KIRKWOOD
> +	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
>  	help
>  	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>  
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 72156c123033..44c358ecf5a1 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -421,7 +421,7 @@ config LEDS_MC13783
>  config LEDS_NS2
>  	tristate "LED support for Network Space v2 GPIO LEDs"
>  	depends on LEDS_CLASS
> -	depends on ARCH_KIRKWOOD
> +	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
>  	default y
>  	help
>  	  This option enable support for the dual-GPIO LED found on the
> @@ -431,7 +431,7 @@ config LEDS_NS2
>  config LEDS_NETXBIG
>  	tristate "LED support for Big Network series LEDs"
>  	depends on LEDS_CLASS
> -	depends on ARCH_KIRKWOOD
> +	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
>  	default y
>  	help
>  	  This option enable support for LEDs found on the LaCie 2Big
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index afa2354f6600..5e6b33f9c294 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -24,7 +24,7 @@ config PHY_EXYNOS_MIPI_VIDEO
>  
>  config PHY_MVEBU_SATA
>  	def_bool y
> -	depends on ARCH_KIRKWOOD || ARCH_DOVE
> +	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD
>  	depends on OF
>  	select GENERIC_PHY
>  
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 35c066489a19..1bc9cbc4f1b8 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -142,7 +142,7 @@ config RCAR_THERMAL
>  
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> -	depends on ARCH_KIRKWOOD
> +	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
>  	depends on OF
>  	help
>  	  Support for the Kirkwood thermal sensor driver into the Linux thermal
> diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
> index 78ed4a42ad21..106e2e22fed2 100644
> --- a/sound/soc/kirkwood/Kconfig
> +++ b/sound/soc/kirkwood/Kconfig
> @@ -1,6 +1,6 @@
>  config SND_KIRKWOOD_SOC
>  	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
> -	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
> +	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD || COMPILE_TEST
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the Kirkwood I2S interface. You will also need to select the
> 
