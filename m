From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:02 +0900
Subject: [PATCH 066/142] sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and
 functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-67-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  276 ++++++++++++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index de13348..e16ec10 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1658,6 +1658,277 @@ static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
+/* - LCD0 ------------------------------------------------------------------- */
+static const unsigned int lcd0_data8_pins[] = {
+	/* D[0:7] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+};
+static const unsigned int lcd0_data8_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+};
+static const unsigned int lcd0_data9_pins[] = {
+	/* D[0:8] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50,
+};
+static const unsigned int lcd0_data9_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK,
+};
+static const unsigned int lcd0_data12_pins[] = {
+	/* D[0:11] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50, 49, 48, 47,
+};
+static const unsigned int lcd0_data12_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+};
+static const unsigned int lcd0_data16_pins[] = {
+	/* D[0:15] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50, 49, 48, 47, 46, 45, 44, 43,
+};
+static const unsigned int lcd0_data16_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
+};
+static const unsigned int lcd0_data18_pins[] = {
+	/* D[0:17] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50, 49, 48, 47, 46, 45, 44, 43,
+	42, 41,
+};
+static const unsigned int lcd0_data18_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
+	LCD0_D16_MARK, LCD0_D17_MARK,
+};
+static const unsigned int lcd0_data24_0_pins[] = {
+	/* D[0:23] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50, 49, 48, 47, 46, 45, 44, 43,
+	42, 41, 40, 4, 3, 2, 0, 1,
+};
+static const unsigned int lcd0_data24_0_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
+	LCD0_D16_MARK, LCD0_D17_MARK, LCD0_D18_PORT40_MARK, LCD0_D19_PORT4_MARK,
+	LCD0_D20_PORT3_MARK, LCD0_D21_PORT2_MARK, LCD0_D22_PORT0_MARK,
+	LCD0_D23_PORT1_MARK,
+};
+static const unsigned int lcd0_data24_1_pins[] = {
+	/* D[0:23] */
+	58, 57, 56, 55, 54, 53, 52, 51,
+	50, 49, 48, 47, 46, 45, 44, 43,
+	42, 41, 163, 162, 161, 158, 160, 159,
+};
+static const unsigned int lcd0_data24_1_mux[] = {
+	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
+	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
+	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D16_MARK, LCD0_D17_MARK, LCD0_D18_PORT163_MARK,
+	LCD0_D19_PORT162_MARK, LCD0_D20_PORT161_MARK, LCD0_D21_PORT158_MARK,
+	LCD0_D22_PORT160_MARK, LCD0_D23_PORT159_MARK,
+};
+static const unsigned int lcd0_display_pins[] = {
+	/* DON, VCPWC, VEPWC */
+	61, 59, 60,
+};
+static const unsigned int lcd0_display_mux[] = {
+	LCD0_DON_MARK, LCD0_VCPWC_MARK, LCD0_VEPWC_MARK,
+};
+static const unsigned int lcd0_lclk_0_pins[] = {
+	/* LCLK */
+	102,
+};
+static const unsigned int lcd0_lclk_0_mux[] = {
+	LCD0_LCLK_PORT102_MARK,
+};
+static const unsigned int lcd0_lclk_1_pins[] = {
+	/* LCLK */
+	165,
+};
+static const unsigned int lcd0_lclk_1_mux[] = {
+	LCD0_LCLK_PORT165_MARK,
+};
+static const unsigned int lcd0_sync_pins[] = {
+	/* VSYN, HSYN, DCK, DISP */
+	63, 64, 62, 65,
+};
+static const unsigned int lcd0_sync_mux[] = {
+	LCD0_VSYN_MARK, LCD0_HSYN_MARK, LCD0_DCK_MARK, LCD0_DISP_MARK,
+};
+static const unsigned int lcd0_sys_pins[] = {
+	/* CS, WR, RD, RS */
+	64, 62, 164, 65,
+};
+static const unsigned int lcd0_sys_mux[] = {
+	LCD0_CS_MARK, LCD0_WR_MARK, LCD0_RD_MARK, LCD0_RS_MARK,
+};
+/* - LCD1 ------------------------------------------------------------------- */
+static const unsigned int lcd1_data8_pins[] = {
+	/* D[0:7] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+};
+static const unsigned int lcd1_data8_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+};
+static const unsigned int lcd1_data9_pins[] = {
+	/* D[0:8] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+	93,
+};
+static const unsigned int lcd1_data9_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+	LCD1_D8_MARK,
+};
+static const unsigned int lcd1_data12_pins[] = {
+	/* D[0:12] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+	93, 94, 21, 201,
+};
+static const unsigned int lcd1_data12_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+	LCD1_D8_MARK, LCD1_D9_MARK, LCD1_D10_MARK, LCD1_D11_MARK,
+};
+static const unsigned int lcd1_data16_pins[] = {
+	/* D[0:15] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+	93, 94, 21, 201, 200, 199, 196, 195,
+};
+static const unsigned int lcd1_data16_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+	LCD1_D8_MARK, LCD1_D9_MARK, LCD1_D10_MARK, LCD1_D11_MARK,
+	LCD1_D12_MARK, LCD1_D13_MARK, LCD1_D14_MARK, LCD1_D15_MARK,
+};
+static const unsigned int lcd1_data18_pins[] = {
+	/* D[0:17] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+	93, 94, 21, 201, 200, 199, 196, 195,
+	194, 193,
+};
+static const unsigned int lcd1_data18_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+	LCD1_D8_MARK, LCD1_D9_MARK, LCD1_D10_MARK, LCD1_D11_MARK,
+	LCD1_D12_MARK, LCD1_D13_MARK, LCD1_D14_MARK, LCD1_D15_MARK,
+	LCD1_D16_MARK, LCD1_D17_MARK,
+};
+static const unsigned int lcd1_data24_pins[] = {
+	/* D[0:23] */
+	4, 3, 2, 1, 0, 91, 92, 23,
+	93, 94, 21, 201, 200, 199, 196, 195,
+	194, 193, 198, 197, 75, 74, 15, 14,
+};
+static const unsigned int lcd1_data24_mux[] = {
+	LCD1_D0_MARK, LCD1_D1_MARK, LCD1_D2_MARK, LCD1_D3_MARK,
+	LCD1_D4_MARK, LCD1_D5_MARK, LCD1_D6_MARK, LCD1_D7_MARK,
+	LCD1_D8_MARK, LCD1_D9_MARK, LCD1_D10_MARK, LCD1_D11_MARK,
+	LCD1_D12_MARK, LCD1_D13_MARK, LCD1_D14_MARK, LCD1_D15_MARK,
+	LCD1_D16_MARK, LCD1_D17_MARK, LCD1_D18_MARK, LCD1_D19_MARK,
+	LCD1_D20_MARK, LCD1_D21_MARK, LCD1_D22_MARK, LCD1_D23_MARK,
+};
+static const unsigned int lcd1_display_pins[] = {
+	/* DON, VCPWC, VEPWC */
+	100, 5, 6,
+};
+static const unsigned int lcd1_display_mux[] = {
+	LCD1_DON_MARK, LCD1_VCPWC_MARK, LCD1_VEPWC_MARK,
+};
+static const unsigned int lcd1_lclk_pins[] = {
+	/* LCLK */
+	40,
+};
+static const unsigned int lcd1_lclk_mux[] = {
+	LCD1_LCLK_MARK,
+};
+static const unsigned int lcd1_sync_pins[] = {
+	/* VSYN, HSYN, DCK, DISP */
+	98, 97, 99, 12,
+};
+static const unsigned int lcd1_sync_mux[] = {
+	LCD1_VSYN_MARK, LCD1_HSYN_MARK, LCD1_DCK_MARK, LCD1_DISP_MARK,
+};
+static const unsigned int lcd1_sys_pins[] = {
+	/* CS, WR, RD, RS */
+	97, 99, 13, 12,
+};
+static const unsigned int lcd1_sys_mux[] = {
+	LCD1_CS_MARK, LCD1_WR_MARK, LCD1_RD_MARK, LCD1_RS_MARK,
+};
+
+static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(lcd0_data8),
+	SH_PFC_PIN_GROUP(lcd0_data9),
+	SH_PFC_PIN_GROUP(lcd0_data12),
+	SH_PFC_PIN_GROUP(lcd0_data16),
+	SH_PFC_PIN_GROUP(lcd0_data18),
+	SH_PFC_PIN_GROUP(lcd0_data24_0),
+	SH_PFC_PIN_GROUP(lcd0_data24_1),
+	SH_PFC_PIN_GROUP(lcd0_display),
+	SH_PFC_PIN_GROUP(lcd0_lclk_0),
+	SH_PFC_PIN_GROUP(lcd0_lclk_1),
+	SH_PFC_PIN_GROUP(lcd0_sync),
+	SH_PFC_PIN_GROUP(lcd0_sys),
+	SH_PFC_PIN_GROUP(lcd1_data8),
+	SH_PFC_PIN_GROUP(lcd1_data9),
+	SH_PFC_PIN_GROUP(lcd1_data12),
+	SH_PFC_PIN_GROUP(lcd1_data16),
+	SH_PFC_PIN_GROUP(lcd1_data18),
+	SH_PFC_PIN_GROUP(lcd1_data24),
+	SH_PFC_PIN_GROUP(lcd1_display),
+	SH_PFC_PIN_GROUP(lcd1_lclk),
+	SH_PFC_PIN_GROUP(lcd1_sync),
+	SH_PFC_PIN_GROUP(lcd1_sys),
+};
+
+static const char * const lcd0_groups[] = {
+	"lcd0_data8",
+	"lcd0_data9",
+	"lcd0_data12",
+	"lcd0_data16",
+	"lcd0_data18",
+	"lcd0_data24_0",
+	"lcd0_data24_1",
+	"lcd0_display",
+	"lcd0_lclk_0",
+	"lcd0_lclk_1",
+	"lcd0_sync",
+	"lcd0_sys",
+};
+
+static const char * const lcd1_groups[] = {
+	"lcd1_data8",
+	"lcd1_data9",
+	"lcd1_data12",
+	"lcd1_data16",
+	"lcd1_data18",
+	"lcd1_data24",
+	"lcd1_display",
+	"lcd1_lclk",
+	"lcd1_sync",
+	"lcd1_sys",
+};
+
+static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(lcd0),
+	SH_PFC_FUNCTION(lcd1),
+};
+
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static const struct pinmux_func pinmux_func_gpios[] = {
@@ -2596,6 +2867,11 @@ const struct sh_pfc_soc_info r8a7740_pinmux_info = {
 
 	.pins		= pinmux_pins,
 	.nr_pins	= ARRAY_SIZE(pinmux_pins),
+	.groups		= pinmux_groups,
+	.nr_groups	= ARRAY_SIZE(pinmux_groups),
+	.functions	= pinmux_functions,
+	.nr_functions	= ARRAY_SIZE(pinmux_functions),
+
 	.func_gpios	= pinmux_func_gpios,
 	.nr_func_gpios	= ARRAY_SIZE(pinmux_func_gpios),
 
-- 
1.7.10.4
