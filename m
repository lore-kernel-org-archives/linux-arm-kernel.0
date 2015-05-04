From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 10:16:14 +0200
Subject: [PATCH v6 19/25] iommu: exynos: remove unneeded code
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430727380-10912-20-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once driver initialization has been moved from initcall to of_xlate()
callback, this patch is no longer needed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6e6b502ee2c9..821797328c52 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1126,15 +1126,8 @@ static bool init_done;
 
 static int __init exynos_iommu_init(void)
 {
-	struct device_node *np;
 	int ret;
 
-	np = of_find_matching_node(NULL, sysmmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
 	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
 	if (!lv2table_kmem_cache) {
-- 
1.9.2
