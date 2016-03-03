From: julien.grall@arm.com (Julien Grall)
Date: Thu, 3 Mar 2016 16:26:31 +0000
Subject: [RFC v5 03/17] iommu: introduce a reserved iova cookie
In-Reply-To: <1456856877-4817-4-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
 <1456856877-4817-4-git-send-email-eric.auger@linaro.org>
Message-ID: <56D865B7.7000404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 01/03/16 18:27, Eric Auger wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0e3b009..7b2bb94 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1072,6 +1072,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>
>   	domain->ops  = bus->iommu_ops;
>   	domain->type = type;
> +	mutex_init(&domain->reserved_mutex);

For consistency, the RB-tree reserved_binding_list should be initialized 
too:

domain->reserved_binding_list = RB_ROOT;

Cheers,

-- 
Julien Grall
