From: briannorris@chromium.org (Brian Norris)
Date: Mon, 28 Nov 2016 16:42:27 -0800
Subject: [PATCH v5 8/8] iommu/rockchip: Enable Rockchip IOMMU on ARM64
In-Reply-To: <1466734413-7453-9-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-9-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20161129004225.GA109697@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 24, 2016 at 10:13:33AM +0800, Shunqian Zheng wrote:
> From: Simon Xue <xxm@rock-chips.com>
> 
> This patch makes it possible to compile the rockchip-iommu driver on
> ARM64, so that it can be used with 64-bit SoCs equipped with this type
> of IOMMU.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index ad08603..5572621 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -218,7 +218,7 @@ config OMAP_IOMMU_DEBUG
>  
>  config ROCKCHIP_IOMMU
>  	bool "Rockchip IOMMU Support"
> -	depends on ARM
> +	depends on ARM || ARM64
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	select IOMMU_API
>  	select ARM_DMA_USE_IOMMU

Whatever happened with the rest of this series? Some of the IOMMU bits
made it, but the DRM fixes never did, and so this didn't get applied.
This leaves the whole DRM stack unusable on ARM64 Rockchip systems.

The patch context has changed a bit on patch 7 (and maybe 6?), so
somebody will need to refresh those on the latest upstream.

Brian
