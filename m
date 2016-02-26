From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 16:28:11 +0900
Subject: [RESPIN 4/6] ARM: EXYNOS: Remove SROM related register settings
 from mach-exynos
In-Reply-To: <1456389222-12738-5-git-send-email-pankaj.dubey@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
 <1456389222-12738-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56CFFE8B.80002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2016 17:33, Pankaj Dubey wrote:
> As now we have dedicated driver for SROM controller, it will take care
> of saving register banks during S2R so we can safely remove these
> settings from mach-exynos.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                 |  2 ++
>  arch/arm/mach-exynos/exynos.c                | 17 ---------
>  arch/arm/mach-exynos/include/mach/map.h      |  3 --
>  arch/arm/mach-exynos/regs-srom.h             | 53 ----------------------------
>  arch/arm/mach-exynos/suspend.c               | 20 ++---------
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  1 -
>  6 files changed, 4 insertions(+), 92 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/regs-srom.h
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index c4989c2..8da01d1 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -18,6 +18,7 @@ menuconfig ARCH_EXYNOS
>  	select COMMON_CLK_SAMSUNG
>  	select EXYNOS_THERMAL
>  	select EXYNOS_PMU
> +	select EXYNOS_SROM if PM
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_S3C2410_I2C if I2C
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
> @@ -30,6 +31,7 @@ menuconfig ARCH_EXYNOS
>  	select SRAM
>  	select THERMAL
>  	select MFD_SYSCON
> +	select MEMORY

select SAMSUNG_MC because otherwise the directory won't be build
(memory/Kconfig).

Rest looks good. No need to respin (I can fix this when applying),
unless other people will have some comments.

BR,
Krzysztof
