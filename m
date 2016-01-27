From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 22:38:30 +0100
Subject: [PATCH] pinctrl: nomadik: stn8815 CLCD alternate functions
Message-ID: <1453930710-19163-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STn8815 has 22 dedicated pins for CLCD with up to 16 bits
in parallel, but pins 32 thru 39 can be used for an additional
CLCD signal lines 16 thru 23.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
index 587b222f12f3..e852048c4c04 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c
@@ -287,6 +287,10 @@ static const unsigned i2c0_a_1_pins[] = { STN8815_PIN_D3, STN8815_PIN_D2 };
 /* Altfunction B */
 static const unsigned u1_b_1_pins[] = { STN8815_PIN_B16, STN8815_PIN_A16 };
 static const unsigned i2cusb_b_1_pins[] = { STN8815_PIN_C21, STN8815_PIN_C20 };
+static const unsigned clcd_16_23_b_1_pins[] = { STN8815_PIN_AB6,
+	STN8815_PIN_AA6, STN8815_PIN_Y6, STN8815_PIN_Y5, STN8815_PIN_AA5,
+	STN8815_PIN_AB5, STN8815_PIN_AB4, STN8815_PIN_Y4 };
+
 
 #define STN8815_PIN_GROUP(a, b) { .name = #a, .pins = a##_pins,		\
 			.npins = ARRAY_SIZE(a##_pins), .altsetting = b }
@@ -302,6 +306,7 @@ static const struct nmk_pingroup nmk_stn8815_groups[] = {
 	STN8815_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
 	STN8815_PIN_GROUP(u1_b_1, NMK_GPIO_ALT_B),
 	STN8815_PIN_GROUP(i2cusb_b_1, NMK_GPIO_ALT_B),
+	STN8815_PIN_GROUP(clcd_16_23_b_1, NMK_GPIO_ALT_B),
 };
 
 /* We use this macro to define the groups applicable to a function */
@@ -314,6 +319,7 @@ STN8815_FUNC_GROUPS(u1, "u1_a_1", "u1_b_1");
 STN8815_FUNC_GROUPS(i2c1, "i2c1_a_1");
 STN8815_FUNC_GROUPS(i2c0, "i2c0_a_1");
 STN8815_FUNC_GROUPS(i2cusb, "i2cusb_b_1");
+STN8815_FUNC_GROUPS(clcd, "clcd_16_23_b_1");
 
 #define FUNCTION(fname)					\
 	{						\
@@ -329,6 +335,7 @@ static const struct nmk_function nmk_stn8815_functions[] = {
 	FUNCTION(i2c1),
 	FUNCTION(i2c0),
 	FUNCTION(i2cusb),
+	FUNCTION(clcd),
 };
 
 static const struct nmk_pinctrl_soc_data nmk_stn8815_soc = {
-- 
2.4.3
