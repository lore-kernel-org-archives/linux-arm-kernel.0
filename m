From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Jan 2017 15:46:58 -0800
Subject: [PATCH] perf: xgene: Include module.h
Message-ID: <20170125234658.12071-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I ran into a build error when I disabled CONFIG_ACPI and tried to
compile this driver:

drivers/perf/xgene_pmu.c:1242:1: warning: data definition has no type or storage class
 MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
 ^
drivers/perf/xgene_pmu.c:1242:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]

Include module.h for the MODULE_DEVICE_TABLE macro that's
implicitly included through ACPI.

Cc: Tai Nguyen <ttnguyen@apm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/perf/xgene_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index a8ac4bcef2c0..fb3281962a6d 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
