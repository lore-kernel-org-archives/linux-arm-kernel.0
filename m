From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 19:26:56 +0200
Subject: [PATCH] ARM: imx: mmdc: Delete an error message for a failed memory
 allocation in imx_mmdc_perf_init()
Message-ID: <99f5fb49-903c-5010-573c-f8ab1a37a246@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 19:15:41 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-imx/mmdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 78262899a590..b073af20e59e 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -486,10 +486,8 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 		of_match_device(imx_mmdc_dt_ids, &pdev->dev);
 
 	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
-	if (!pmu_mmdc) {
-		pr_err("failed to allocate PMU device!\n");
+	if (!pmu_mmdc)
 		return -ENOMEM;
-	}
 
 	/* The first instance registers the hotplug state */
 	if (!cpuhp_mmdc_state) {
-- 
2.13.0
