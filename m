From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 14 Mar 2014 14:05:00 +0900
Subject: [PATCH v11 07/27] iommu/exynos: always enable runtime PM
Message-ID: <20140314140500.d854a6a8fed6ec7c0886a44b@samsung.com>
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
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index bee1bb1..8dc7031 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -632,8 +632,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
-- 
1.7.9.5
