From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Dec 2017 18:09:43 +0100
Subject: [PATCH 1/2] perf: arm_spe: Delete an error message for a failed
 memory allocation in arm_spe_pmu_device_dt_probe()
In-Reply-To: <8a92bb8f-4295-6912-19a4-9103226a3c62@users.sourceforge.net>
References: <8a92bb8f-4295-6912-19a4-9103226a3c62@users.sourceforge.net>
Message-ID: <09c83c44-aebb-f5cb-b398-1986bdbd52db@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2017 17:27:23 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/perf/arm_spe_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8ce262fc2561..27fac8907d1d 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1166,9 +1166,7 @@ static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
 
 	spe_pmu = devm_kzalloc(dev, sizeof(*spe_pmu), GFP_KERNEL);
-	if (!spe_pmu) {
-		dev_err(dev, "failed to allocate spe_pmu\n");
+	if (!spe_pmu)
 		return -ENOMEM;
-	}
 
 	spe_pmu->handle = alloc_percpu(typeof(*spe_pmu->handle));
 	if (!spe_pmu->handle)
-- 
2.15.1
