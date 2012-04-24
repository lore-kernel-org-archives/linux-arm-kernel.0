From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Apr 2012 16:05:31 +0200
Subject: [PATCH 10/18][V3] ARM: OMAP3: cpuidle - remove errata check in the
 init function
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1335276339-11135-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The errata check is done in the next_valid_state function, no need to check
that in the omap3_idle_init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 11a2c23..f394ea6 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -430,16 +430,6 @@ int __init omap3_idle_init(void)
 
 	/* C7 . MPU OFF + Core OFF */
 	cx = _fill_cstate_usage(dev, 6);
-	/*
-	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
-	 * enable OFF mode in a stable form for previous revisions.
-	 * We disable C7 state as a result.
-	 */
-	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
-		cx->valid = 0;
-		pr_warn("%s: core off state C7 disabled due to i583\n",
-			__func__);
-	}
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_OFF;
 
-- 
1.7.5.4
