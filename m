From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 28 Jan 2016 17:15:23 +0000
Subject: [RFC PATCH 3/6] of: iommu: Increment DT node refcount in
 of_iommu_set_ops()
In-Reply-To: <1453872079-27140-4-git-send-email-anup.patel@broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <56AA4CAB.6000708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 05:21, Anup Patel wrote:
> We are saving pointer to iommu DT node in of_iommu_set_ops()
> hence we should increment DT node ref count.

Oh man, shame on whoever wrote that code! :P

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   drivers/iommu/of_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 60ba238..5fea665 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -110,6 +110,7 @@ void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
>   	if (WARN_ON(!iommu))
>   		return;
>
> +	of_node_get(np);
>   	INIT_LIST_HEAD(&iommu->list);
>   	iommu->np = np;
>   	iommu->ops = ops;
>
