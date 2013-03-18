From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:53 +0900
Subject: [PATCH 057/142] sh-pfc: sh73a0: Add LCD and LCD2 pin groups and
 functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-58-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  254 +++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index f31adfc..c8b2604 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1846,6 +1846,255 @@ static const struct pinmux_range pinmux_ranges[] = {
 	{.begin = 288, .end = 309,},
 };
 
+/* - LCD -------------------------------------------------------------------- */
+static const unsigned int lcd_data8_pins[] = {
+	/* D[0:7] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+};
+static const unsigned int lcd_data8_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+};
+static const unsigned int lcd_data9_pins[] = {
+	/* D[0:8] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200,
+};
+static const unsigned int lcd_data9_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+	LCDD8_MARK,
+};
+static const unsigned int lcd_data12_pins[] = {
+	/* D[0:11] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200, 201, 202, 203,
+};
+static const unsigned int lcd_data12_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+	LCDD8_MARK, LCDD9_MARK, LCDD10_MARK, LCDD11_MARK,
+};
+static const unsigned int lcd_data16_pins[] = {
+	/* D[0:15] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200, 201, 202, 203, 204, 205, 206, 207,
+};
+static const unsigned int lcd_data16_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+	LCDD8_MARK, LCDD9_MARK, LCDD10_MARK, LCDD11_MARK,
+	LCDD12_MARK, LCDD13_MARK, LCDD14_MARK, LCDD15_MARK,
+};
+static const unsigned int lcd_data18_pins[] = {
+	/* D[0:17] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200, 201, 202, 203, 204, 205, 206, 207,
+	208, 209,
+};
+static const unsigned int lcd_data18_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+	LCDD8_MARK, LCDD9_MARK, LCDD10_MARK, LCDD11_MARK,
+	LCDD12_MARK, LCDD13_MARK, LCDD14_MARK, LCDD15_MARK,
+	LCDD16_MARK, LCDD17_MARK,
+};
+static const unsigned int lcd_data24_pins[] = {
+	/* D[0:23] */
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200, 201, 202, 203, 204, 205, 206, 207,
+	208, 209, 210, 211, 212, 213, 214, 215
+};
+static const unsigned int lcd_data24_mux[] = {
+	LCDD0_MARK, LCDD1_MARK, LCDD2_MARK, LCDD3_MARK,
+	LCDD4_MARK, LCDD5_MARK, LCDD6_MARK, LCDD7_MARK,
+	LCDD8_MARK, LCDD9_MARK, LCDD10_MARK, LCDD11_MARK,
+	LCDD12_MARK, LCDD13_MARK, LCDD14_MARK, LCDD15_MARK,
+	LCDD16_MARK, LCDD17_MARK, LCDD18_MARK, LCDD19_MARK,
+	LCDD20_MARK, LCDD21_MARK, LCDD22_MARK, LCDD23_MARK,
+};
+static const unsigned int lcd_display_pins[] = {
+	/* DON */
+	222,
+};
+static const unsigned int lcd_display_mux[] = {
+	LCDDON_MARK,
+};
+static const unsigned int lcd_lclk_pins[] = {
+	/* LCLK */
+	221,
+};
+static const unsigned int lcd_lclk_mux[] = {
+	LCDLCLK_MARK,
+};
+static const unsigned int lcd_sync_pins[] = {
+	/* VSYN, HSYN, DCK, DISP */
+	220, 218, 216, 219,
+};
+static const unsigned int lcd_sync_mux[] = {
+	LCDVSYN_MARK, LCDHSYN_MARK, LCDDCK_MARK, LCDDISP_MARK,
+};
+static const unsigned int lcd_sys_pins[] = {
+	/* CS, WR, RD, RS */
+	218, 216, 217, 219,
+};
+static const unsigned int lcd_sys_mux[] = {
+	LCDCS__MARK, LCDWR__MARK, LCDRD__MARK, LCDRS_MARK,
+};
+/* - LCD2 ------------------------------------------------------------------- */
+static const unsigned int lcd2_data8_pins[] = {
+	/* D[0:7] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+};
+static const unsigned int lcd2_data8_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+};
+static const unsigned int lcd2_data9_pins[] = {
+	/* D[0:8] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+	140,
+};
+static const unsigned int lcd2_data9_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+	LCD2D8_MARK,
+};
+static const unsigned int lcd2_data12_pins[] = {
+	/* D[0:12] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+	140, 141, 130, 131,
+};
+static const unsigned int lcd2_data12_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+	LCD2D8_MARK, LCD2D9_MARK, LCD2D10_MARK, LCD2D11_MARK,
+};
+static const unsigned int lcd2_data16_pins[] = {
+	/* D[0:15] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+	140, 141, 130, 131, 132, 133, 134, 135,
+};
+static const unsigned int lcd2_data16_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+	LCD2D8_MARK, LCD2D9_MARK, LCD2D10_MARK, LCD2D11_MARK,
+	LCD2D12_MARK, LCD2D13_MARK, LCD2D14_MARK, LCD2D15_MARK,
+};
+static const unsigned int lcd2_data18_pins[] = {
+	/* D[0:17] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+	140, 141, 130, 131, 132, 133, 134, 135,
+	136, 137,
+};
+static const unsigned int lcd2_data18_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+	LCD2D8_MARK, LCD2D9_MARK, LCD2D10_MARK, LCD2D11_MARK,
+	LCD2D12_MARK, LCD2D13_MARK, LCD2D14_MARK, LCD2D15_MARK,
+	LCD2D16_MARK, LCD2D17_MARK,
+};
+static const unsigned int lcd2_data24_pins[] = {
+	/* D[0:23] */
+	128, 129, 142, 143, 144, 145, 138, 139,
+	140, 141, 130, 131, 132, 133, 134, 135,
+	136, 137, 146, 147, 234, 235, 238, 239
+};
+static const unsigned int lcd2_data24_mux[] = {
+	LCD2D0_MARK, LCD2D1_MARK, LCD2D2_MARK, LCD2D3_MARK,
+	LCD2D4_MARK, LCD2D5_MARK, LCD2D6_MARK, LCD2D7_MARK,
+	LCD2D8_MARK, LCD2D9_MARK, LCD2D10_MARK, LCD2D11_MARK,
+	LCD2D12_MARK, LCD2D13_MARK, LCD2D14_MARK, LCD2D15_MARK,
+	LCD2D16_MARK, LCD2D17_MARK, LCD2D18_MARK, LCD2D19_MARK,
+	LCD2D20_MARK, LCD2D21_MARK, LCD2D22_MARK, LCD2D23_MARK,
+};
+static const unsigned int lcd2_sync_0_pins[] = {
+	/* VSYN, HSYN, DCK, DISP */
+	128, 129, 146, 145,
+};
+static const unsigned int lcd2_sync_0_mux[] = {
+	PORT128_LCD2VSYN_MARK, PORT129_LCD2HSYN_MARK,
+	LCD2DCK_MARK, PORT145_LCD2DISP_MARK,
+};
+static const unsigned int lcd2_sync_1_pins[] = {
+	/* VSYN, HSYN, DCK, DISP */
+	222, 221, 219, 217,
+};
+static const unsigned int lcd2_sync_1_mux[] = {
+	PORT222_LCD2VSYN_MARK, PORT221_LCD2HSYN_MARK,
+	LCD2DCK_2_MARK, PORT217_LCD2DISP_MARK,
+};
+static const unsigned int lcd2_sys_0_pins[] = {
+	/* CS, WR, RD, RS */
+	129, 146, 147, 145,
+};
+static const unsigned int lcd2_sys_0_mux[] = {
+	PORT129_LCD2CS__MARK, PORT146_LCD2WR__MARK,
+	LCD2RD__MARK, PORT145_LCD2RS_MARK,
+};
+static const unsigned int lcd2_sys_1_pins[] = {
+	/* CS, WR, RD, RS */
+	221, 219, 147, 217,
+};
+static const unsigned int lcd2_sys_1_mux[] = {
+	PORT221_LCD2CS__MARK, PORT219_LCD2WR__MARK,
+	LCD2RD__MARK, PORT217_LCD2RS_MARK,
+};
+
+static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(lcd_data8),
+	SH_PFC_PIN_GROUP(lcd_data9),
+	SH_PFC_PIN_GROUP(lcd_data12),
+	SH_PFC_PIN_GROUP(lcd_data16),
+	SH_PFC_PIN_GROUP(lcd_data18),
+	SH_PFC_PIN_GROUP(lcd_data24),
+	SH_PFC_PIN_GROUP(lcd_display),
+	SH_PFC_PIN_GROUP(lcd_lclk),
+	SH_PFC_PIN_GROUP(lcd_sync),
+	SH_PFC_PIN_GROUP(lcd_sys),
+	SH_PFC_PIN_GROUP(lcd2_data8),
+	SH_PFC_PIN_GROUP(lcd2_data9),
+	SH_PFC_PIN_GROUP(lcd2_data12),
+	SH_PFC_PIN_GROUP(lcd2_data16),
+	SH_PFC_PIN_GROUP(lcd2_data18),
+	SH_PFC_PIN_GROUP(lcd2_data24),
+	SH_PFC_PIN_GROUP(lcd2_sync_0),
+	SH_PFC_PIN_GROUP(lcd2_sync_1),
+	SH_PFC_PIN_GROUP(lcd2_sys_0),
+	SH_PFC_PIN_GROUP(lcd2_sys_1),
+};
+
+static const char * const lcd_groups[] = {
+	"lcd_data8",
+	"lcd_data9",
+	"lcd_data12",
+	"lcd_data16",
+	"lcd_data18",
+	"lcd_data24",
+	"lcd_display",
+	"lcd_lclk",
+	"lcd_sync",
+	"lcd_sys",
+};
+
+static const char * const lcd2_groups[] = {
+	"lcd2_data8",
+	"lcd2_data9",
+	"lcd2_data12",
+	"lcd2_data16",
+	"lcd2_data18",
+	"lcd2_data24",
+	"lcd2_sync_0",
+	"lcd2_sync_1",
+	"lcd2_sys_0",
+	"lcd2_sys_1",
+};
+
+static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(lcd),
+	SH_PFC_FUNCTION(lcd2),
+};
+
 #define PINMUX_FN_BASE	GPIO_FN_VBUS_0
 
 static const struct pinmux_func pinmux_func_gpios[] = {
@@ -3140,6 +3389,11 @@ const struct sh_pfc_soc_info sh73a0_pinmux_info = {
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
 	.ranges = pinmux_ranges,
 	.nr_ranges = ARRAY_SIZE(pinmux_ranges),
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
 	.func_gpios = pinmux_func_gpios,
 	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
 
-- 
1.7.10.4
