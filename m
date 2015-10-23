From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 03:34:58 +0900
Subject: [PATCH v5 8/8] ARM: EXYNOS: Remove SROM related register settings
 from mach-exynos
In-Reply-To: <1445332540-12814-9-git-send-email-pankaj.dubey@samsung.com>
References: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
 <1445332540-12814-9-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <562A7DD2.2000000@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/15 18:15, Pankaj Dubey wrote:
> As now we have dedicated driver for SROM controller, it will take care
> of saving register banks during S2R so we can safely remove these
> settings from mach-exynos.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
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
> index 3a10f1a..62c3139 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -27,6 +27,8 @@ menuconfig ARCH_EXYNOS
>  	select SRAM
>  	select THERMAL
>  	select MFD_SYSCON
> +	select SOC_SAMSUNG
> +	select EXYNOS_SROM if PM

Please add them in alphabetical next time...I've changed the order in
this time.

Thanks,
Kukjin
