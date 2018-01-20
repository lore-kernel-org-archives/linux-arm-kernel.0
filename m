From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 20 Jan 2018 14:34:57 +0100
Subject: [PATCH] Exynos-IOMMU: Delete an error message for a failed memory
 allocation in exynos_iommu_init()
Message-ID: <1cdc825c-66d2-03ec-f7e5-935ca8d01f7e@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 14:28:13 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iommu/exynos-iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 79c45650f8de..456a88483089 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1370,8 +1370,6 @@ static int __init exynos_iommu_init(void)
 
 	zero_lv2_table = kmem_cache_zalloc(lv2table_kmem_cache, GFP_KERNEL);
 	if (zero_lv2_table == NULL) {
-		pr_err("%s: Failed to allocate zero level2 page table\n",
-			__func__);
 		ret = -ENOMEM;
 		goto err_zero_lv2;
 	}
-- 
2.15.1
