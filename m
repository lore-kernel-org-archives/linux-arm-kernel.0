From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 28 Oct 2012 21:29:47 +0100
Subject: [PATCH] pinctrl/nomadik: db8500: fix kp pin group
Message-ID: <1351456187-15111-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

kp_a_2 pin group was defined but was not declared
as a group of kp function.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik-db8500.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik-db8500.c b/drivers/pinctrl/pinctrl-nomadik-db8500.c
index ef6f26d..6de52e7 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8500.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8500.c
@@ -691,6 +691,7 @@ static const struct nmk_pingroup nmk_db8500_groups[] = {
 	DB8500_PIN_GROUP(i2c0_a_1, NMK_GPIO_ALT_A),
 	DB8500_PIN_GROUP(ipgpio0_a_1, NMK_GPIO_ALT_A),
 	DB8500_PIN_GROUP(ipgpio1_a_1, NMK_GPIO_ALT_A),
+	DB8500_PIN_GROUP(kp_a_2, NMK_GPIO_ALT_A),
 	DB8500_PIN_GROUP(msp2sck_a_1, NMK_GPIO_ALT_A),
 	DB8500_PIN_GROUP(msp2_a_1, NMK_GPIO_ALT_A),
 	DB8500_PIN_GROUP(mc4_a_1, NMK_GPIO_ALT_A),
@@ -834,7 +835,7 @@ DB8500_FUNC_GROUPS(msp1, "msp1txrx_a_1", "msp1_a_1", "msp1txrx_b_1");
 DB8500_FUNC_GROUPS(lcdb, "lcdb_a_1");
 DB8500_FUNC_GROUPS(lcd, "lcdvsi0_a_1", "lcdvsi1_a_1", "lcd_d0_d7_a_1",
 	"lcd_d8_d11_a_1", "lcd_d12_d23_a_1", "lcd_b_1");
-DB8500_FUNC_GROUPS(kp, "kp_a_1", "kp_b_1", "kp_b_2", "kp_c_1", "kp_oc1_1");
+DB8500_FUNC_GROUPS(kp, "kp_a_1", "kp_a_2", "kp_b_1", "kp_b_2", "kp_c_1", "kp_oc1_1");
 DB8500_FUNC_GROUPS(mc2, "mc2_a_1", "mc2rstn_c_1");
 DB8500_FUNC_GROUPS(ssp1, "ssp1_a_1");
 DB8500_FUNC_GROUPS(ssp0, "ssp0_a_1");
-- 
1.7.11.3
