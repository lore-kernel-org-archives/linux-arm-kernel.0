From: pullip.cho@samsung.com (Cho KyongHo)
Date: Mon, 07 Oct 2013 10:54:12 +0900
Subject: [PATCH v10 06/20] iommu/exynos: always enable runtime PM
Message-ID: <20131007105412.afe839f84bcaa19de1b7278f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking if the probing device has a parent device was just to discover
if the probing device is involved in a power domain when the power
domain controlled by Samsung's custom implementation.
Since generic IO power domain is applied, it is required to remove
the condition to see if the probing device has a parent device.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 191cb3f..20b032f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -644,8 +644,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
-- 
1.7.2.5
