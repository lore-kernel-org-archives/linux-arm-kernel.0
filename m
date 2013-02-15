From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:02 +0000
Subject: [PATCH 32/40] ab8500-charger: Remove duplicate code
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-33-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/ab8500_charger.c |    8 --------
 drivers/power/ab8500_fg.c      |    1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 8530028..81c9615 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3184,14 +3184,6 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 		goto out;
 	}
 
-	/* Set charger watchdog timeout */
-	ret = abx500_set_register_interruptible(di->dev, AB8500_CHARGER,
-		AB8500_CH_WD_TIMER_REG, WD_TIMER);
-	if (ret) {
-		dev_err(di->dev, "failed to set charger watchdog timeout\n");
-		goto out;
-	}
-
 	ret = ab8500_charger_led_en(di, false);
 	if (ret < 0) {
 		dev_err(di->dev, "failed to disable LED\n");
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index f596883..54c6417 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -1680,7 +1680,6 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 		break;
 
 	case AB8500_FG_DISCHARGE_WAKEUP:
-		ab8500_fg_coulomb_counter(di, true);
 		ab8500_fg_calc_cap_discharge_voltage(di, true);
 
 		di->fg_samples = SEC_TO_SAMPLE(
-- 
1.7.10.4
