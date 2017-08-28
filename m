From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 17:42:05 +0530
Subject: [PATCH 1/3] iommu: exynos: constify iommu_ops
Message-ID: <1503922325-25905-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2395478..a540016 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -569,7 +569,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static struct iommu_ops exynos_iommu_ops;
+static const struct iommu_ops exynos_iommu_ops;
 
 static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 {
@@ -1323,7 +1323,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
-static struct iommu_ops exynos_iommu_ops = {
+static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.domain_free = exynos_iommu_domain_free,
 	.attach_dev = exynos_iommu_attach_device,
-- 
1.9.1
