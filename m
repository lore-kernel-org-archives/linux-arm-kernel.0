From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:44:52 +0530
Subject: [PATCH v13 07/19] iommu/exynos: always enable runtime PM
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-8-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

Checking if the probing device has a parent device was just to discover
if the probing device is involved in a power domain when the power
domain controlled by Samsung's custom implementation.
Since generic IO power domain is applied, it is required to remove
the condition to see if the probing device has a parent device.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6915235..ef771a2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -558,8 +558,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
-- 
1.7.9.5
