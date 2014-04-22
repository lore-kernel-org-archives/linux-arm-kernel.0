From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Apr 2014 20:06:06 -0700
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAOesGMh0VdSbQ1fSjGkJOG+BDeNfo4NNQjtiznh18DxSROaT1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 2:28 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This makes it possible to enable the exynos platform as part of a
> multiplatform kernel, in addition to keeping the single-platform
> Exynos support.
> sparsemem is currently not supported in multiplatform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/Kconfig                  |   27 +++------------------------
>  arch/arm/configs/exynos_defconfig |    2 +-
>  arch/arm/mach-exynos/Kconfig      |   27 +++++++++++++++++++++++++++
>  arch/arm/mach-exynos/Makefile     |    2 ++
>  arch/arm/plat-samsung/Makefile    |    3 +++
>  5 files changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4422601059e8..9d459e9c396b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -828,34 +828,13 @@ config ARCH_S5PV210
>         help
>           Samsung S5PV210/S5PC110 series based systems
>
> -config ARCH_EXYNOS
> +config ARCH_EXYNOS_SINGLE
>         bool "Samsung EXYNOS"
> -       select ARCH_HAS_BANDGAP
> -       select ARCH_HAS_CPUFREQ
> -       select ARCH_HAS_HOLES_MEMORYMODEL
> -       select ARCH_REQUIRE_GPIOLIB
> +       select ARCH_EXYNOS
>         select ARCH_SPARSEMEM_ENABLE
> -       select ARM_AMBA
> -       select ARM_GIC
> -       select CLKSRC_OF
> -       select COMMON_CLK
> -       select CPU_V7
> -       select GENERIC_CLOCKEVENTS
> -       select HAVE_ARM_SCU if SMP
> -       select HAVE_S3C2410_I2C if I2C
> -       select HAVE_S3C2410_WATCHDOG if WATCHDOG
> -       select HAVE_S3C_RTC if RTC_CLASS
> -       select HAVE_SMP
>         select NEED_MACH_MEMORY_H
> -       select PINCTRL
> -       select PINCTRL_EXYNOS
> -       select PM_GENERIC_DOMAINS if PM_RUNTIME
> -       select S5P_DEV_MFC
> -       select SAMSUNG_DMADEV
> -       select SPARSE_IRQ
> -       select USE_OF
>         help
> -         Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
> +         Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)

I don't think there's a point in keeping this around. A
"single-platform" config is just enabling a single platform in the
config, it's not a specific option. I don't think any of the other
platforms use anything like this today.

-Olof
