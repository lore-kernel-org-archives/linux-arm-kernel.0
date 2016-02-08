From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Feb 2016 10:47:31 +0530
Subject: [PATCH v2 3/4] of: iommu: Increment DT node refcount in
 of_iommu_set_ops()
In-Reply-To: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1454908652-15317-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are saving pointer to iommu DT node in of_iommu_set_ops()
hence we should increment DT node ref count.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Reviewed-by: Robin Murphy <Robin.Murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 60ba238..5fea665 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -110,6 +110,7 @@ void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
 	if (WARN_ON(!iommu))
 		return;
 
+	of_node_get(np);
 	INIT_LIST_HEAD(&iommu->list);
 	iommu->np = np;
 	iommu->ops = ops;
-- 
1.9.1
