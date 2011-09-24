From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sat, 24 Sep 2011 09:38:46 +0900
Subject: [PATCH 4/4] iommu/exynos: Use bus_set_iommu instead of register_iommu
In-Reply-To: <1316824726-20695-1-git-send-email-pullip.cho@samsung.com>
References: <1316824726-20695-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1316824726-20695-5-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces register_iommu() with bus_set_iommu() according to the
suggestion of Joerg Roedel.

Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos_iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/exynos_iommu.c b/drivers/iommu/exynos_iommu.c
index fe5b5d8..148e238 100644
--- a/drivers/iommu/exynos_iommu.c
+++ b/drivers/iommu/exynos_iommu.c
@@ -852,7 +852,7 @@ static int __init exynos_iommu_init(void)
 	if (!l2table_cachep)
 		return -ENOMEM;
 
-	register_iommu(&exynos_iommu_ops);
+	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
 
 	return 0;
 }
-- 
1.7.1
