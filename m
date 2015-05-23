From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 23 May 2015 19:23:34 +0300
Subject: [PATCH v7 03/25] iommu: Init iommu-groups support earlier,
 in core_initcall
In-Reply-To: <1432041645-11172-4-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1432041645-11172-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <2209337.hhg3lyvUbi@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Thank you for the patch.

On Tuesday 19 May 2015 15:20:23 Marek Szyprowski wrote:
> iommu_group_alloc might be called very early in case of iommu controllers
> activated from of_iommu, so ensure that this part of subsystem is ready
> when devices are being populated from device-tree (core_initcall seems to
> be okay for this case).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d4f527e56679..37a6aa8f318b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1207,7 +1207,7 @@ static int __init iommu_init(void)
> 
>  	return 0;
>  }
> -arch_initcall(iommu_init);
> +core_initcall(iommu_init);

I'll let Joerg comment on this, but this initcall ordering dance always makes 
me feel that something isn't quite right. Have you had a chance to look at the 
patch series I posted about a week ago to implement IOMMU probe deferral 
support ?

>  int iommu_domain_get_attr(struct iommu_domain *domain,
>  			  enum iommu_attr attr, void *data)

-- 
Regards,

Laurent Pinchart
