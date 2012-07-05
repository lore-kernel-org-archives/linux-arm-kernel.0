From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 5 Jul 2012 10:39:50 +0200
Subject: [PATCH] pinctrl/nomadik: add spi2_oc1_2 pin group
Message-ID: <1341477590-27321-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

On 8500 and 9540, all SPI2 pins are driven by SPI block except SPI2_FRM
which is driven as GPIO due to specific constraints.
A new group spi2_oc1_2 is created which exclude SPI2_FRM pin.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik-db8500.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik-db8500.c b/drivers/pinctrl/pinctrl-nomadik-db8500.c
index 9817493..6f99769 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8500.c
@@ -601,6 +601,8 @@ static const unsigned kp_oc1_1_pins[] = { DB8500_PIN_C6, DB8500_PIN_B3,
 	DB8500_PIN_D6, DB8500_PIN_B7 };
 static const unsigned spi2_oc1_1_pins[] = { DB8500_PIN_AH13, DB8500_PIN_AG12,
 	DB8500_PIN_AH12, DB8500_PIN_AH11 };
+static const unsigned spi2_oc1_2_pins[] = { DB8500_PIN_AH13, DB8500_PIN_AH12,
+	DB8500_PIN_AH11 };
 
 #define DB8500_PIN_GROUP(a,b) { .name = #a, .pins = a##_pins,		\
 			.npins = ARRAY_SIZE(a##_pins), .altsetting = b }
@@ -720,6 +722,7 @@ static const struct nmk_pingroup nmk_db8500_groups[] = {
 	/* Other alt C1 column, these are still configured as alt C */
 	DB8500_PIN_GROUP(kp_oc1_1, NMK_GPIO_ALT_C),
 	DB8500_PIN_GROUP(spi2_oc1_1, NMK_GPIO_ALT_C),
+	DB8500_PIN_GROUP(spi2_oc1_2, NMK_GPIO_ALT_C),
 };
 
 /* We use this macro to define the groups applicable to a function */
@@ -795,7 +798,7 @@ DB8500_FUNC_GROUPS(mc5, "mc5_c_1");
 DB8500_FUNC_GROUPS(usbsim, "usbsim_c_1", "usbsim_c_2");
 DB8500_FUNC_GROUPS(i2c3, "i2c3_c_1", "i2c3_c_2");
 DB8500_FUNC_GROUPS(spi0, "spi0_c_1");
-DB8500_FUNC_GROUPS(spi2, "spi2_oc1_1");
+DB8500_FUNC_GROUPS(spi2, "spi2_oc1_1", "spi2_oc1_2");
 
 #define FUNCTION(fname)					\
 	{						\
-- 
1.7.9.2
