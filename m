From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:28 +0900
Subject: [PATCH 20/28] sh-pfc: r8a73a4: Add SCIF pin groups and functions
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add PINCTRL support for r8a73a4 SCIF ports SCIFA0->SCIFA1 and
SCIFB0->SCIFB3.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  287 ++++++++++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 86a5fd3..cd5c5fd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1576,6 +1576,286 @@ static const struct pinmux_range pinmux_ranges[] = {
 	{.begin = 320, .end = 329,},
 };
 
+/* - SCIFA0 ----------------------------------------------------------------- */
+static const unsigned int scifa0_data_pins[] = {
+	/* SCIFA0_RXD, SCIFA0_TXD */
+	117, 116,
+};
+static const unsigned int scifa0_data_mux[] = {
+	SCIFA0_RXD_MARK, SCIFA0_TXD_MARK,
+};
+static const unsigned int scifa0_clk_pins[] = {
+	/* SCIFA0_SCK */
+	34,
+};
+static const unsigned int scifa0_clk_mux[] = {
+	SCIFA0_SCK_MARK,
+};
+static const unsigned int scifa0_ctrl_pins[] = {
+	/* SCIFA0_RTS, SCIFA0_CTS */
+	32, 33,
+};
+static const unsigned int scifa0_ctrl_mux[] = {
+	SCIFA0_RTS_MARK, SCIFA0_CTS_MARK,
+};
+/* - SCIFA1 ----------------------------------------------------------------- */
+static const unsigned int scifa1_data_pins[] = {
+	/* SCIFA1_RXD, SCIFA1_TXD */
+	119, 118,
+};
+static const unsigned int scifa1_data_mux[] = {
+	SCIFA1_RXD_MARK, SCIFA1_TXD_MARK,
+};
+static const unsigned int scifa1_clk_pins[] = {
+	/* SCIFA1_SCK */
+	37,
+};
+static const unsigned int scifa1_clk_mux[] = {
+	SCIFA1_SCK_MARK,
+};
+static const unsigned int scifa1_ctrl_pins[] = {
+	/* SCIFA1_RTS, SCIFA1_CTS */
+	35, 36,
+};
+static const unsigned int scifa1_ctrl_mux[] = {
+	SCIFA1_RTS_MARK, SCIFA1_CTS_MARK,
+};
+/* - SCIFB0 ----------------------------------------------------------------- */
+static const unsigned int scifb0_data_pins[] = {
+	/* SCIFB0_RXD, SCIFB0_TXD */
+	123, 122,
+};
+static const unsigned int scifb0_data_mux[] = {
+	SCIFB0_RXD_MARK, SCIFB0_TXD_MARK,
+};
+static const unsigned int scifb0_clk_pins[] = {
+	/* SCIFB0_SCK */
+	40,
+};
+static const unsigned int scifb0_clk_mux[] = {
+	SCIFB0_SCK_MARK,
+};
+static const unsigned int scifb0_ctrl_pins[] = {
+	/* SCIFB0_RTS, SCIFB0_CTS */
+	38, 39,
+};
+static const unsigned int scifb0_ctrl_mux[] = {
+	SCIFB0_RTS_MARK, SCIFB0_CTS_MARK,
+};
+/* - SCIFB1 ----------------------------------------------------------------- */
+static const unsigned int scifb1_data_pins[] = {
+	/* SCIFB1_RXD, SCIFB1_TXD */
+	27, 26,
+};
+static const unsigned int scifb1_data_mux[] = {
+	SCIFB1_RXD_27_MARK, SCIFB1_TXD_26_MARK,
+};
+static const unsigned int scifb1_clk_pins[] = {
+	/* SCIFB1_SCK */
+	28,
+};
+static const unsigned int scifb1_clk_mux[] = {
+	SCIFB1_SCK_28_MARK,
+};
+static const unsigned int scifb1_ctrl_pins[] = {
+	/* SCIFB1_RTS, SCIFB1_CTS */
+	24, 25,
+};
+static const unsigned int scifb1_ctrl_mux[] = {
+	SCIFB1_RTS_24_MARK, SCIFB1_CTS_25_MARK,
+};
+static const unsigned int scifb1_data_b_pins[] = {
+	/* SCIFB1_RXD, SCIFB1_TXD */
+	72, 67,
+};
+static const unsigned int scifb1_data_b_mux[] = {
+	SCIFB1_RXD_72_MARK, SCIFB1_TXD_67_MARK,
+};
+static const unsigned int scifb1_clk_b_pins[] = {
+	/* SCIFB1_SCK */
+	261,
+};
+static const unsigned int scifb1_clk_b_mux[] = {
+	SCIFB1_SCK_261_MARK,
+};
+static const unsigned int scifb1_ctrl_b_pins[] = {
+	/* SCIFB1_RTS, SCIFB1_CTS */
+	70, 71,
+};
+static const unsigned int scifb1_ctrl_b_mux[] = {
+	SCIFB1_RTS_70_MARK, SCIFB1_CTS_71_MARK,
+};
+/* - SCIFB2 ----------------------------------------------------------------- */
+static const unsigned int scifb2_data_pins[] = {
+	/* SCIFB2_RXD, SCIFB2_TXD */
+	69, 68,
+};
+static const unsigned int scifb2_data_mux[] = {
+	SCIFB2_RXD_69_MARK, SCIFB2_TXD_68_MARK,
+};
+static const unsigned int scifb2_clk_pins[] = {
+	/* SCIFB2_SCK */
+	262,
+};
+static const unsigned int scifb2_clk_mux[] = {
+	SCIFB2_SCK_262_MARK,
+};
+static const unsigned int scifb2_ctrl_pins[] = {
+	/* SCIFB2_RTS, SCIFB2_CTS */
+	73, 66,
+};
+static const unsigned int scifb2_ctrl_mux[] = {
+	SCIFB2_RTS_73_MARK, SCIFB2_CTS_66_MARK,
+};
+static const unsigned int scifb2_data_b_pins[] = {
+	/* SCIFB2_RXD, SCIFB2_TXD */
+	297, 295,
+};
+static const unsigned int scifb2_data_b_mux[] = {
+	SCIFB2_RXD_297_MARK, SCIFB2_TXD_295_MARK,
+};
+static const unsigned int scifb2_clk_b_pins[] = {
+	/* SCIFB2_SCK */
+	299,
+};
+static const unsigned int scifb2_clk_b_mux[] = {
+	SCIFB2_SCK_299_MARK,
+};
+static const unsigned int scifb2_ctrl_b_pins[] = {
+	/* SCIFB2_RTS, SCIFB2_CTS */
+	300, 298,
+};
+static const unsigned int scifb2_ctrl_b_mux[] = {
+	SCIFB2_RTS_300_MARK, SCIFB2_CTS_298_MARK,
+};
+/* - SCIFB3 ----------------------------------------------------------------- */
+static const unsigned int scifb3_data_pins[] = {
+	/* SCIFB3_RXD, SCIFB3_TXD */
+	22, 21,
+};
+static const unsigned int scifb3_data_mux[] = {
+	SCIFB3_RXD_22_MARK, SCIFB3_TXD_21_MARK,
+};
+static const unsigned int scifb3_clk_pins[] = {
+	/* SCIFB3_SCK */
+	23,
+};
+static const unsigned int scifb3_clk_mux[] = {
+	SCIFB3_SCK_23_MARK,
+};
+static const unsigned int scifb3_ctrl_pins[] = {
+	/* SCIFB3_RTS, SCIFB3_CTS */
+	19, 20,
+};
+static const unsigned int scifb3_ctrl_mux[] = {
+	SCIFB3_RTS_19_MARK, SCIFB3_CTS_20_MARK,
+};
+static const unsigned int scifb3_data_b_pins[] = {
+	/* SCIFB3_RXD, SCIFB3_TXD */
+	120, 121,
+};
+static const unsigned int scifb3_data_b_mux[] = {
+	SCIFB3_RXD_120_MARK, SCIFB3_TXD_121_MARK,
+};
+static const unsigned int scifb3_clk_b_pins[] = {
+	/* SCIFB3_SCK */
+	40,
+};
+static const unsigned int scifb3_clk_b_mux[] = {
+	SCIFB3_SCK_40_MARK,
+};
+static const unsigned int scifb3_ctrl_b_pins[] = {
+	/* SCIFB3_RTS, SCIFB3_CTS */
+	38, 39,
+};
+static const unsigned int scifb3_ctrl_b_mux[] = {
+	SCIFB3_RTS_38_MARK, SCIFB3_CTS_39_MARK,
+};
+
+static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(scifa0_data),
+	SH_PFC_PIN_GROUP(scifa0_clk),
+	SH_PFC_PIN_GROUP(scifa0_ctrl),
+	SH_PFC_PIN_GROUP(scifa1_data),
+	SH_PFC_PIN_GROUP(scifa1_clk),
+	SH_PFC_PIN_GROUP(scifa1_ctrl),
+	SH_PFC_PIN_GROUP(scifb0_data),
+	SH_PFC_PIN_GROUP(scifb0_clk),
+	SH_PFC_PIN_GROUP(scifb0_ctrl),
+	SH_PFC_PIN_GROUP(scifb1_data),
+	SH_PFC_PIN_GROUP(scifb1_clk),
+	SH_PFC_PIN_GROUP(scifb1_ctrl),
+	SH_PFC_PIN_GROUP(scifb1_data_b),
+	SH_PFC_PIN_GROUP(scifb1_clk_b),
+	SH_PFC_PIN_GROUP(scifb1_ctrl_b),
+	SH_PFC_PIN_GROUP(scifb2_data),
+	SH_PFC_PIN_GROUP(scifb2_clk),
+	SH_PFC_PIN_GROUP(scifb2_ctrl),
+	SH_PFC_PIN_GROUP(scifb2_data_b),
+	SH_PFC_PIN_GROUP(scifb2_clk_b),
+	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
+	SH_PFC_PIN_GROUP(scifb3_data),
+	SH_PFC_PIN_GROUP(scifb3_clk),
+	SH_PFC_PIN_GROUP(scifb3_ctrl),
+	SH_PFC_PIN_GROUP(scifb3_data_b),
+	SH_PFC_PIN_GROUP(scifb3_clk_b),
+	SH_PFC_PIN_GROUP(scifb3_ctrl_b),
+};
+
+static const char * const scifa0_groups[] = {
+	"scifa0_data",
+	"scifa0_clk",
+	"scifa0_ctrl",
+};
+
+static const char * const scifa1_groups[] = {
+	"scifa1_data",
+	"scifa1_clk",
+	"scifa1_ctrl",
+};
+
+static const char * const scifb0_groups[] = {
+	"scifb0_data",
+	"scifb0_clk",
+	"scifb0_ctrl",
+};
+
+static const char * const scifb1_groups[] = {
+	"scifb1_data",
+	"scifb1_clk",
+	"scifb1_ctrl",
+	"scifb1_data_b",
+	"scifb1_clk_b",
+	"scifb1_ctrl_b",
+};
+
+static const char * const scifb2_groups[] = {
+	"scifb2_data",
+	"scifb2_clk",
+	"scifb2_ctrl",
+	"scifb2_data_b",
+	"scifb2_clk_b",
+	"scifb2_ctrl_b",
+};
+
+static const char * const scifb3_groups[] = {
+	"scifb3_data",
+	"scifb3_clk",
+	"scifb3_ctrl",
+	"scifb3_data_b",
+	"scifb3_clk_b",
+	"scifb3_ctrl_b",
+};
+
+static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(scifa0),
+	SH_PFC_FUNCTION(scifa1),
+	SH_PFC_FUNCTION(scifb0),
+	SH_PFC_FUNCTION(scifb1),
+	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(scifb3),
+};
+
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static const struct pinmux_func pinmux_func_gpios[] = {
@@ -3084,8 +3364,15 @@ const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
+
 	.ranges = pinmux_ranges,
 	.nr_ranges = ARRAY_SIZE(pinmux_ranges),
+
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
 	.func_gpios = pinmux_func_gpios,
 	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
 
-- 
1.7.10.4
