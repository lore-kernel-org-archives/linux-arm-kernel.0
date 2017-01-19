From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 19 Jan 2017 14:48:43 +0100
Subject: [PATCH v3 03/13] soc: samsung: pmu: Remove messages for failed memory
 allocation
In-Reply-To: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134905eucas1p2ed9d6baf6283528289a36a58ee6c978e@eucas1p2.samsung.com>
Message-ID: <1484833733-16082-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory subsystem already prints message about failed memory
allocation, there is no need to do it in the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/soc/samsung/exynos-pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 1f914e63dcc6..813df6e7292d 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -117,10 +117,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	pmu_context = devm_kzalloc(&pdev->dev,
 			sizeof(struct exynos_pmu_context),
 			GFP_KERNEL);
-	if (!pmu_context) {
-		dev_err(dev, "Cannot allocate memory.\n");
+	if (!pmu_context)
 		return -ENOMEM;
-	}
 	pmu_context->dev = dev;
 	pmu_context->pmu_data = of_device_get_match_data(dev);
 
-- 
1.9.1
