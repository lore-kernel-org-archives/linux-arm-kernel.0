From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:54 +0100
Subject: [PATCH 16/19] power: reset: st-poweroff: Remove obsolete platforms.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-17-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes support for STiH415/6 SoC's from the
st-poweroff driver, as support for these platforms is
being removed from the kernel.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <dwmw2@infradead.org>
Cc: <dbaryshkov@gmail.com>
Cc: <sre@kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/power/reset/st-poweroff.c | 41 ---------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/power/reset/st-poweroff.c b/drivers/power/reset/st-poweroff.c
index a488877..2046b31 100644
--- a/drivers/power/reset/st-poweroff.c
+++ b/drivers/power/reset/st-poweroff.c
@@ -28,28 +28,6 @@ struct reset_syscfg {
 	unsigned int mask_rst_msk;
 };
 
-/* STiH415 */
-#define STIH415_SYSCFG_11	0x2c
-#define STIH415_SYSCFG_15	0x3c
-
-static struct reset_syscfg stih415_reset = {
-	.offset_rst = STIH415_SYSCFG_11,
-	.mask_rst = BIT(0),
-	.offset_rst_msk = STIH415_SYSCFG_15,
-	.mask_rst_msk = BIT(0)
-};
-
-/* STiH416 */
-#define STIH416_SYSCFG_500	0x7d0
-#define STIH416_SYSCFG_504	0x7e0
-
-static struct reset_syscfg stih416_reset = {
-	.offset_rst = STIH416_SYSCFG_500,
-	.mask_rst = BIT(0),
-	.offset_rst_msk = STIH416_SYSCFG_504,
-	.mask_rst_msk = BIT(0)
-};
-
 /* STiH407 */
 #define STIH407_SYSCFG_4000	0x0
 #define STIH407_SYSCFG_4008	0x20
@@ -61,16 +39,6 @@ static struct reset_syscfg stih407_reset = {
 	.mask_rst_msk = BIT(0)
 };
 
-/* STiD127 */
-#define STID127_SYSCFG_700	0x0
-#define STID127_SYSCFG_773	0x124
-
-static struct reset_syscfg stid127_reset = {
-	.offset_rst = STID127_SYSCFG_773,
-	.mask_rst = BIT(0),
-	.offset_rst_msk = STID127_SYSCFG_700,
-	.mask_rst_msk = BIT(8)
-};
 
 static struct reset_syscfg *st_restart_syscfg;
 
@@ -99,17 +67,8 @@ static struct notifier_block st_restart_nb = {
 
 static const struct of_device_id st_reset_of_match[] = {
 	{
-		.compatible = "st,stih415-restart",
-		.data = (void *)&stih415_reset,
-	}, {
-		.compatible = "st,stih416-restart",
-		.data = (void *)&stih416_reset,
-	}, {
 		.compatible = "st,stih407-restart",
 		.data = (void *)&stih407_reset,
-	}, {
-		.compatible = "st,stid127-restart",
-		.data = (void *)&stid127_reset,
 	},
 	{}
 };
-- 
1.9.1
