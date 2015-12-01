From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 01 Dec 2015 12:03:16 +0300
Subject: [PATCH v3 5/5] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
References: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
 <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
Message-ID: <010401d12c17$1e883d10$5b98b730$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

Tested it on top of 4.4-rc3.
 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 3a10f1a8317a..d279edf9b10d 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -27,6 +27,9 @@ menuconfig ARCH_EXYNOS
>  	select SRAM
>  	select THERMAL
>  	select MFD_SYSCON
> +	select POWER_RESET
> +	select POWER_RESET_SYSCON
> +	select POWER_RESET_SYSCON_POWEROFF

"select POWER_SUPPLY" is missing here. Without is we get:
--- cut ---
warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS && REALVIEW_DT) selects POWER_RESET which has unmet direct
dependencies (POWER_SUPPLY)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
--- cut ---

>  	help
>  	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)

 Otherwise works fine.

 Tested-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
