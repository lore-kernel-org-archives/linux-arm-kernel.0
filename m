From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 04 Feb 2015 11:59:23 +0900
Subject: [PATCH 1/2] drm/exynos: fix DMA_ATTR_NO_KERNEL_MAPPING usage
In-Reply-To: <1422953252-10835-2-git-send-email-carlo@caione.org>
References: <1422953252-10835-1-git-send-email-carlo@caione.org>
 <1422953252-10835-2-git-send-email-carlo@caione.org>
Message-ID: <54D18B0B.5060208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/03/2015 05:47 PM, Carlo Caione wrote:
> The Exynos DRM driver doesn't follow the correct API when dealing with
> dma_{alloc, mmap, free}_attrs functions and the
> DMA_ATTR_NO_KERNEL_MAPPING attribute.
> 
> When a IOMMU is not available and the DMA_ATTR_NO_KERNEL_MAPPING is
> used, the driver should use the pointer returned by dma_alloc_attr() as
> a cookie.
> 
> The Exynos DRM driver directly uses the non-requested virtual
> kernel address returned by the DMA mapping subsystem. This just works
> now because the non-IOMMU codepath doesn't obey
> DMA_ATTR_NO_KERNEL_MAPPING but we need to fix it before fixing the DMA
> layer.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_buf.c   |  6 +++---
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 29 +++++++++--------------------
>  drivers/gpu/drm/exynos/exynos_drm_gem.h   |  2 ++
>  3 files changed, 14 insertions(+), 23 deletions(-)
> 

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.
