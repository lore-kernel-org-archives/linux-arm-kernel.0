From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:05 +0000
Subject: [PATCH 35/40] ab8500-bm: Trivially fix up some incorrect and
 out-of-date comments
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-36-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <marcus.xm.cooper@stericsson.com>

Some of the comments in the ab8500 drivers reflect the behaviour
of the original device. As this driver now supports newer devices
then these comments are now redundant. Also some IRQ comments are
incorrect.

Signed-off-by: Marcus Cooper <marcus.xm.cooper@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Rabin VINCENT <rabin.vincent@stericsson.com>
Tested-by: Rabin VINCENT <rabin.vincent@stericsson.com>
---
 drivers/power/ab8500_btemp.c |    4 ++--
 drivers/power/ab8500_fg.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 7336dcf..a9486f1 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -158,7 +158,7 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
 	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL) {
 		/*
 		 * If the battery has internal NTC, we use the current
-		 * source to calculate the resistance, 7uA or 20uA
+		 * source to calculate the resistance.
 		 */
 		rbs = (v_batctrl * 1000
 		       - di->bm->gnd_lift_resistance * inst_curr)
@@ -602,7 +602,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 
 	/*
 	 * We only have to change current source if the
-	 * detected type is Type 1, else we use the 7uA source
+	 * detected type is Type 1.
 	 */
 	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL &&
 	    di->bm->batt_id == 1) {
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 54c6417..7de5333 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -1979,7 +1979,7 @@ static void ab8500_fg_instant_work(struct work_struct *work)
 }
 
 /**
- * ab8500_fg_cc_data_end_handler() - isr to get battery avg current.
+ * ab8500_fg_cc_data_end_handler() - end of data conversion isr.
  * @irq:       interrupt number
  * @_di:       pointer to the ab8500_fg structure
  *
@@ -1999,7 +1999,7 @@ static irqreturn_t ab8500_fg_cc_data_end_handler(int irq, void *_di)
 }
 
 /**
- * ab8500_fg_cc_convend_handler() - isr to get battery avg current.
+ * ab8500_fg_cc_int_calib_handler () - end of calibration isr.
  * @irq:       interrupt number
  * @_di:       pointer to the ab8500_fg structure
  *
-- 
1.7.10.4
