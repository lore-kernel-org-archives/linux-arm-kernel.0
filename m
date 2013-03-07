From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 10:12:52 +0900
Subject: [PATCH] ARM: EXYNOS: remove EXYNOS_DEV_SYSMMU entirely
In-Reply-To: <1362509466.16460.108.camel@x61.thuisdomein>
References: <1362509466.16460.108.camel@x61.thuisdomein>
Message-ID: <014f01ce1ad0$e4432b10$acc98130$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> Commit 25e9d28d927d2e1731df53f60cde53d75bcb7c36 ("ARM: EXYNOS: remove
> system mmu initialization from exynos tree") removed the Kconfig symbol
> EXYNOS_DEV_SYSMMU. Remove its last traces too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) Please note that this patch changes the dependencies of EXYNOS_IOMMU
> (it removed a dependency that could never be met). That's probably what
> needs to be done but some specific review is needed here.
> 
>  arch/arm/mach-exynos/Kconfig | 4 ----
>  drivers/iommu/Kconfig        | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 70f94c8..6c2bdc3 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -200,7 +200,6 @@ config MACH_SMDKV310
>  	select EXYNOS4_SETUP_USB_PHY
>  	select EXYNOS_DEV_DMA
>  	select EXYNOS_DEV_DRM
> -	select EXYNOS_DEV_SYSMMU
>  	select S3C24XX_PWM
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
> @@ -254,7 +253,6 @@ config MACH_UNIVERSAL_C210
>  	select EXYNOS4_SETUP_USB_PHY
>  	select EXYNOS_DEV_DMA
>  	select EXYNOS_DEV_DRM
> -	select EXYNOS_DEV_SYSMMU
>  	select HAVE_SCHED_CLOCK
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC2
> @@ -331,7 +329,6 @@ config MACH_ORIGEN
>  	select EXYNOS4_SETUP_USB_PHY
>  	select EXYNOS_DEV_DMA
>  	select EXYNOS_DEV_DRM
> -	select EXYNOS_DEV_SYSMMU
>  	select S3C24XX_PWM
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC2
> @@ -367,7 +364,6 @@ config MACH_SMDK4212
>  	select EXYNOS4_SETUP_USB_PHY
>  	select EXYNOS_DEV_DMA
>  	select EXYNOS_DEV_DRM
> -	select EXYNOS_DEV_SYSMMU
>  	select S3C24XX_PWM
>  	select S3C_DEV_HSMMC2
>  	select S3C_DEV_HSMMC3
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 5c514d07..c520c20 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -168,7 +168,7 @@ config TEGRA_IOMMU_SMMU
> 
>  config EXYNOS_IOMMU
>  	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> +	depends on ARCH_EXYNOS
>  	select IOMMU_API
>  	help
>  	  Support for the IOMMU(System MMU) of Samsung Exynos application
> --
> 1.7.11.7

Actually, to update iommu for exynos is on-going. And as I know, it will be done this time for v3.10 by KyongHo Cho, so it would be better to handle this cleanup with that at the same time.

Thanks.

- Kukjin
