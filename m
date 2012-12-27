From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 27 Dec 2012 15:15:40 +0100
Subject: [PATCH] arm: dma mapping: export arm iommu functions
In-Reply-To: <1356592458-11077-1-git-send-email-prathyush.k@samsung.com>
References: <1356592458-11077-1-git-send-email-prathyush.k@samsung.com>
Message-ID: <50DC580C.7080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 12/27/2012 8:14 AM, Prathyush K wrote:
> This patch adds EXPORT_SYMBOL calls to the three arm iommu
> functions - arm_iommu_create_mapping, arm_iommu_free_mapping
> and arm_iommu_attach_device. These functions can now be called
> from dynamic modules.

Could You describe a bit more why those functions might be needed by 
dynamic modules?

> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
> ---
>   arch/arm/mm/dma-mapping.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6b2fb87..c0f0f43 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1797,6 +1797,7 @@ err2:
>   err:
>   	return ERR_PTR(err);
>   }
> +EXPORT_SYMBOL(arm_iommu_create_mapping);

EXPORT_SYMOBL_GPL() ?

>   static void release_iommu_mapping(struct kref *kref)
>   {
> @@ -1813,6 +1814,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
>   	if (mapping)
>   		kref_put(&mapping->kref, release_iommu_mapping);
>   }
> +EXPORT_SYMBOL(arm_iommu_release_mapping);
>   
>   /**
>    * arm_iommu_attach_device
> @@ -1841,5 +1843,6 @@ int arm_iommu_attach_device(struct device *dev,
>   	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
>   	return 0;
>   }
> +EXPORT_SYMBOL(arm_iommu_attach_device);
>   
>   #endif

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
