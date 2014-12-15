From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Mon, 15 Dec 2014 14:10:37 +0100
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
In-Reply-To: <1418648413-32013-1-git-send-email-broonie@kernel.org>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
Message-ID: <548EDDCD.4060203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.12.2014 14:00, Mark Brown wrote:
> The Exynos IOMMU driver uses the ARM specific dmac_flush_range() and
> outer_flush_range() functions. This breaks the build on arm64 allmodconfig
> in -next since support has been merged for some Exynos ARMv8 SoCs. Add a
> dependency on ARM to keep things building until either the driver has the
> ARM dependencies removed or the ARMv8 architecture code implements these
> ARM specific APIs.

Hi Mark,

Few days ago I posted similar patch:
https://lkml.org/lkml/2014/12/5/268
but no one have picked it up.

Anyway the fix of yours seems fine to me.

Best regards,
Krzysztof

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 01e8bfae569b..325188eef1c1 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -187,7 +187,7 @@ config TEGRA_IOMMU_SMMU
>  
>  config EXYNOS_IOMMU
>  	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS
> +	depends on ARCH_EXYNOS && ARM
>  	select IOMMU_API
>  	select ARM_DMA_USE_IOMMU
>  	help
> 
