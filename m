From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:09 +0000
Subject: [PATCH 39/40] ab8500-fg: Change current calculation
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-40-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: lme00437 <benoit.gauthier-nonst@stericsson.com>

This patch updates the gas gauge constant for electric current
calculation according to hardware specification.

Signed-off-by: Benoit GAUTHIER <benoit.gauthier-xsig@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-by: Philippe LANGLAIS <philippe.langlais@stericsson.com>
Tested-by: Benoit GAUTHIER <benoit.gauthier-xsig@stericsson.com>
---
 drivers/power/ab8500_fg.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 7de5333..4968061 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -36,7 +36,7 @@
 
 #define MILLI_TO_MICRO			1000
 #define FG_LSB_IN_MA			1627
-#define QLSB_NANO_AMP_HOURS_X10		1129
+#define QLSB_NANO_AMP_HOURS_X10		1071
 #define INS_CURR_TIMEOUT		(3 * HZ)
 
 #define SEC_TO_SAMPLE(S)		(S * 4)
@@ -672,11 +672,11 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 	/*
 	 * Convert to unit value in mA
 	 * Full scale input voltage is
-	 * 66.660mV => LSB = 66.660mV/(4096*res) = 1.627mA
+	 * 63.160mV => LSB = 63.160mV/(4096*res) = 1.542mA
 	 * Given a 250ms conversion cycle time the LSB corresponds
-	 * to 112.9 nAh. Convert to current by dividing by the conversion
+	 * to 107.1 nAh. Convert to current by dividing by the conversion
 	 * time in hours (250ms = 1 / (3600 * 4)h)
-	 * 112.9nAh assumes 10mOhm, but fg_res is in 0.1mOhm
+	 * 107.1nAh assumes 10mOhm, but fg_res is in 0.1mOhm
 	 */
 	val = (val * QLSB_NANO_AMP_HOURS_X10 * 36 * 4) /
 		(1000 * di->bm->fg_res);
-- 
1.7.10.4
