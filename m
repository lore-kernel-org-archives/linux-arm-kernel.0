From: andre.przywara@arm.com (Andre Przywara)
Date: Sun, 18 Mar 2018 23:28:44 +0000
Subject: [PATCH v2 1/4] pwm: sun4i: drop unused .has_rdy member
In-Reply-To: <20180318232847.14278-1-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Message-ID: <20180318232847.14278-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a054c4d68408 ("pwm: sun4i: Drop legacy callbacks") dropped the
only user of the .has_rdy member in our sun4i_pwm_data struct.
Consequently we don't need to store this anymore for the various SoCs,
which paves the way for further simplifications.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/pwm/pwm-sun4i.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 334199c58f1d..b3e4a4b3774d 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -73,7 +73,6 @@ static const u32 prescaler_table[] = {
 
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
-	bool has_rdy;
 	unsigned int npwm;
 };
 
@@ -313,31 +312,26 @@ static const struct pwm_ops sun4i_pwm_ops = {
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
-	.has_rdy = false,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 1,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 1,
 };
 
-- 
2.14.1
