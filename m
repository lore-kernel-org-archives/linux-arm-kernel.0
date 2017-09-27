From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Wed, 27 Sep 2017 14:30:24 +0800
Subject: [PATCH] drivers/perf: arm_pmu_acpi: drop redundant acpi_disabled check
Message-ID: <1506493824-94829-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

acpi_disabled has been checked in armv8_pmu_driver_init and it shall
be ZERO in arm_pmu_acpi_probe, clean up this unnecessary check.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/arm_pmu_acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 3303dd8..705f1a3 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -193,9 +193,6 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 	int pmu_idx = 0;
 	int cpu, ret;
 
-	if (acpi_disabled)
-		return 0;
-
 	/*
 	 * Initialise and register the set of PMUs which we know about right
 	 * now. Ideally we'd do this in arm_pmu_acpi_cpu_starting() so that we
-- 
1.9.1
