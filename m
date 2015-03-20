From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 20 Mar 2015 18:57:35 +0200
Subject: [PATCH v2 1/3] iommu: remove unused priv field from struct
 iommu_ops
In-Reply-To: <1426870234-12910-2-git-send-email-will.deacon@arm.com>
References: <1426870234-12910-1-git-send-email-will.deacon@arm.com>
 <1426870234-12910-2-git-send-email-will.deacon@arm.com>
Message-ID: <37551406.SOpXx0e8El@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you for the patch.

On Friday 20 March 2015 16:50:32 Will Deacon wrote:
> The priv field from iommu_ops is a hangover from the of_dma_configure
> series and isn't actually used. Remove it before it has chance to
> spread.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 38daa453f2e5..73b7bb29546c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -109,7 +109,6 @@ enum iommu_attr {
>   * @domain_set_attr: Change domain attributes
>   * @of_xlate: add OF master IDs to iommu grouping
>   * @pgsize_bitmap: bitmap of supported page sizes
> - * @priv: per-instance data private to the iommu driver
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -146,7 +145,6 @@ struct iommu_ops {
>  #endif
> 
>  	unsigned long pgsize_bitmap;
> -	void *priv;
>  };
> 
>  #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */

-- 
Regards,

Laurent Pinchart
