From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Sep 2011 16:31:49 +0900
Subject: [PATCH v2 5/5] iommu/exynos: Use bus_set_iommu instead of
	register_iommu
Message-ID: <017001cc7f43$04a2db60$0de89220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KyongHo Cho <pullip.cho@samsung.com>

This replaces register_iommu() with bus_set_iommu() according to the
suggestion of Joerg Roedel.

Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/iommu/exynos_iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/exynos_iommu.c b/drivers/iommu/exynos_iommu.c
index d355a2e..e36f7b2 100644
--- a/drivers/iommu/exynos_iommu.c
+++ b/drivers/iommu/exynos_iommu.c
@@ -912,7 +912,7 @@ static int __init exynos_iommu_init(void)
 	if (!l2table_cachep)
 		return -ENOMEM;
 
-	register_iommu(&exynos_iommu_ops);
+	bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
 
 	return 0;
 }
-- 
1.7.1
