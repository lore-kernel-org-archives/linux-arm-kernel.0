From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 4 Oct 2012 14:46:48 +0200
Subject: [PATCH] ARM: ux500: 8500: register LCD VSI pinctrl table
Message-ID: <1349354808-18299-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

This fixes up the pins used by the VSI interface to the HDMI
AV8100 encoder.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index a267c6d..8ab8688 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -162,7 +162,10 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_MUX("lcd_d8_d11_a_1", "lcd", "mcde-tvout"),
 	DB8500_MUX("lcdaclk_b_1", "lcda", "mcde-tvout"),
 	/* Mux in LCD VSI1 and pull it up for MCDE HDMI output */
-	DB8500_MUX("lcdvsi1_a_1", "lcd", "av8100-hdmi"),
+	DB8500_MUX("lcdvsi1_a_1", "lcd", "0-0070"),
+	DB8500_PIN("GPIO69_E2", in_pu, "0-0070"),
+	/* LCD VSI1 sleep state */
+	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
 	/* Mux in i2c0 block, default state */
 	DB8500_MUX("i2c0_a_1", "i2c0", "nmk-i2c.0"),
 	/* i2c0 sleep state */
-- 
1.7.11.3
