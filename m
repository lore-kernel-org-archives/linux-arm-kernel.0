From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Mon, 28 Aug 2017 17:54:54 +0200
Subject: [PATCH 3/3] iommu: s390: constify iommu_ops
In-Reply-To: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170828175454.1401491a@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Aug 2017 17:42:50 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> iommu_ops are not supposed to change at runtime.
> Functions 'bus_set_iommu' working with const iommu_ops provided
> by <linux/iommu.h>. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 8788640..400d75f 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -327,7 +327,7 @@ static size_t s390_iommu_unmap(struct iommu_domain *domain,
>  	return size;
>  }
> 
> -static struct iommu_ops s390_iommu_ops = {
> +static const struct iommu_ops s390_iommu_ops = {
>  	.capable = s390_iommu_capable,
>  	.domain_alloc = s390_domain_alloc,
>  	.domain_free = s390_domain_free,
