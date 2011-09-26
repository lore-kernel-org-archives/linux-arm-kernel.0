From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 13:42:50 +0900
Subject: [PATCH 4/4 v2] iommu/exynos: Use bus_set_iommu instead of
	register_iommu
In-Reply-To: <1317012170-28597-1-git-send-email-pullip.cho@samsung.com>
References: <1317012170-28597-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1317012170-28597-5-git-send-email-pullip.cho@samsung.com>
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
index 9b3f108..34e673f 100644
--- a/drivers/iommu/exynos_iommu.c
+++ b/drivers/iommu/exynos_iommu.c
@@ -926,7 +926,7 @@ static int __init exynos_iommu_init(void)
 	if (!l2table_cachep)
 		return -ENOMEM;
 
-	register_iommu(&exynos_iommu_ops);
+	bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
 
 	return 0;
 }
-- 
1.7.1
