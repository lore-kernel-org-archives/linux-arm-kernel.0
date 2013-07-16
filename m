From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Jul 2013 12:39:42 +0900
Subject: [PATCH] ARM: EXYNOS: Enable 64-bit DMA for EXYNOS5440 if LPAE is
 enabled
In-Reply-To: <109701ce667b$179822e0$46c868a0$%kim@samsung.com>
References: <109701ce667b$179822e0$46c868a0$%kim@samsung.com>
Message-ID: <027701ce81d6$1b857a80$52906f80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Allow 64-bit DMA addresses if LPAE is enabled on EXYNOS5440.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index e101b14..0f7d308 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -81,6 +81,7 @@ config SOC_EXYNOS5440
>  	bool "SAMSUNG EXYNOS5440"
>  	default y
>  	depends on ARCH_EXYNOS5
> +	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	select ARCH_HAS_OPP
>  	select ARM_ARCH_TIMER
>  	select AUTO_ZRELADDR
> --
> 1.7.10.4

OK, applied into -fixes for 3.11-rc because current SSDK5440 cannot boot
without this.

Thanks,
- Kukjin
