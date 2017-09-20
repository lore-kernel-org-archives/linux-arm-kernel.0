From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 12:26:38 +0530
Subject: [PATCH] drivers/perf: arm_pmu_acpi: Release memory obtained by
 kasprintf
Message-ID: <f3b19a8ba9ca69fe84b0d980b6337a33a1da907d.1505884534.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free memory region, if arm_pmu_acpi_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0a9b787..3303dd8 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -235,6 +235,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 		ret = armpmu_register(pmu);
 		if (ret) {
 			pr_warn("Failed to register PMU for CPU%d\n", cpu);
+			kfree(pmu->name);
 			return ret;
 		}
 	}
-- 
1.9.1
