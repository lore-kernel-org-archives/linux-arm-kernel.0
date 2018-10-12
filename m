From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Oct 2018 14:24:09 -0500
Subject: [PATCH 1/2] perf: arm_spe: Enable automatic DT loading
Message-ID: <20181012192409.3819792-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When built as a module, the spe driver isn't automatically
loaded on DT systems. Add the MODULE_DEVICE_TABLE entry.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 54ec278d2fc4..18d61077b157 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1169,6 +1169,7 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
 	{ .compatible = "arm,statistical-profiling-extension-v1", .data = (void *)1 },
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
 
 static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
 {
-- 
2.14.3
