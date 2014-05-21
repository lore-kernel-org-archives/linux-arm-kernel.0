From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 10:16:18 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1400655169-21683-3-git-send-email-sachin.kamat@linaro.org>
References: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
 <1400655169-21683-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <4352730.lnFJpo5XeV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 12:22:48 Sachin Kamat wrote:
>  # Configuration options for the EXYNOS4
>  
> +config ARCH_EXYNOS
> +       bool "Samsung EXYNOS" if ARCH_MULTI_V7
> +       select ARCH_HAS_BANDGAP
> +       select ARCH_HAS_CPUFREQ
> +       select ARCH_HAS_HOLES_MEMORYMODEL
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARM_AMBA
> +       select ARM_GIC
> +       select CLKSRC_OF
> +       select COMMON_CLK_SAMSUNG
> +       select CPU_V7
> +       select GENERIC_CLOCKEVENTS
> +       select HAVE_ARM_SCU if SMP
> +       select HAVE_S3C2410_I2C if I2C
> +       select HAVE_S3C2410_WATCHDOG if WATCHDOG
> +       select HAVE_S3C_RTC if RTC_CLASS
> +       select HAVE_SMP
> +       select PINCTRL
> +       select PINCTRL_EXYNOS
> +       select PM_GENERIC_DOMAINS if PM_RUNTIME
> +       select S5P_DEV_MFC
> +       select SAMSUNG_DMADEV
> +       select SPARSE_IRQ
> +       select SRAM
> +       select USE_OF
> +       help
> +         Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
> +
> 

A number of these can be removed now: SPARSE_IRQ, USE_OF, GENERIC_CLOCKEVENTS,
CLKSRC_OF, CPU_V7 and HAVE_SMP are implied by ARCH_MULTIPLATFORM or ARCH_MULTI_V7,
so we shouldn't duplicate them here.

I believe SAMSUNG_DMADEV cannot work in multiplatform, but we also don't need
it any more.

The rest looks good.

	Arnd
