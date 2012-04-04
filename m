From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:37 +0200
Subject: [PATCH 03/17][V2] ARM: OMAP4: cpuidle - Remove the
 cpuidle_params_table table
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not longer need this table as we defined the values
in the driver states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 6d86b59..cdd7932 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -31,16 +31,7 @@ struct omap4_idle_statedata {
 	u32 mpu_state;
 };
 
-static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	{.exit_latency = 2 + 2 , .target_residency = 5 },
-	/* C2- CPU0 OFF + CPU1 OFF + MPU CSWR */
-	{.exit_latency = 328 + 440 , .target_residency = 960 },
-	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	{.exit_latency = 460 + 518 , .target_residency = 1100 },
-};
-
-#define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
+#define OMAP4_NUM_STATES 3
 
 struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
-- 
1.7.5.4
