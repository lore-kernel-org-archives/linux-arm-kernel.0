From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:57 +0900
Subject: [PATCH 061/142] sh-pfc: sh73a0: Add SDHI and MMCIF pin groups and
 functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-62-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add pin group definitions for SDHI0, SDHI1, SDHI2 and MMCIF interfaces on
sh73a0.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  194 +++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 0d35f7b..ed5cbaf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2263,6 +2263,66 @@ static const unsigned int lcd2_sys_1_mux[] = {
 	PORT221_LCD2CS__MARK, PORT219_LCD2WR__MARK,
 	LCD2RD__MARK, PORT217_LCD2RS_MARK,
 };
+/* - MMCIF ------------------------------------------------------------------ */
+static const unsigned int mmc0_data1_0_pins[] = {
+	/* D[0] */
+	271,
+};
+static const unsigned int mmc0_data1_0_mux[] = {
+	MMCD0_0_MARK,
+};
+static const unsigned int mmc0_data4_0_pins[] = {
+	/* D[0:3] */
+	271, 272, 273, 274,
+};
+static const unsigned int mmc0_data4_0_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+};
+static const unsigned int mmc0_data8_0_pins[] = {
+	/* D[0:7] */
+	271, 272, 273, 274, 275, 276, 277, 278,
+};
+static const unsigned int mmc0_data8_0_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+	MMCD0_4_MARK, MMCD0_5_MARK, MMCD0_6_MARK, MMCD0_7_MARK,
+};
+static const unsigned int mmc0_ctrl_0_pins[] = {
+	/* CMD, CLK */
+	279, 270,
+};
+static const unsigned int mmc0_ctrl_0_mux[] = {
+	MMCCMD0_MARK, MMCCLK0_MARK,
+};
+
+static const unsigned int mmc0_data1_1_pins[] = {
+	/* D[0] */
+	305,
+};
+static const unsigned int mmc0_data1_1_mux[] = {
+	MMCD1_0_MARK,
+};
+static const unsigned int mmc0_data4_1_pins[] = {
+	/* D[0:3] */
+	305, 304, 303, 302,
+};
+static const unsigned int mmc0_data4_1_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+};
+static const unsigned int mmc0_data8_1_pins[] = {
+	/* D[0:7] */
+	305, 304, 303, 302, 301, 300, 299, 298,
+};
+static const unsigned int mmc0_data8_1_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+	MMCD1_4_MARK, MMCD1_5_MARK, MMCD1_6_MARK, MMCD1_7_MARK,
+};
+static const unsigned int mmc0_ctrl_1_pins[] = {
+	/* CMD, CLK */
+	297, 289,
+};
+static const unsigned int mmc0_ctrl_1_mux[] = {
+	MMCCMD1_MARK, MMCCLK1_MARK,
+};
 /* - SCIFA0 ----------------------------------------------------------------- */
 static const unsigned int scifa0_data_pins[] = {
 	/* RXD, TXD */
@@ -2510,6 +2570,86 @@ static const unsigned int scifb_ctrl_1_pins[] = {
 static const unsigned int scifb_ctrl_1_mux[] = {
 	PORT245_SCIFB_RTS__MARK, PORT244_SCIFB_CTS__MARK,
 };
+/* - SDHI0 ------------------------------------------------------------------ */
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	252,
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SDHID0_0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	252, 253, 254, 255,
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SDHID0_0_MARK, SDHID0_1_MARK, SDHID0_2_MARK, SDHID0_3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CMD, CLK */
+	256, 250,
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SDHICMD0_MARK, SDHICLK0_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	251,
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SDHICD0_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	257,
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SDHIWP0_MARK,
+};
+/* - SDHI1 ------------------------------------------------------------------ */
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	259,
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SDHID1_0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	259, 260, 261, 262,
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SDHID1_0_MARK, SDHID1_1_MARK, SDHID1_2_MARK, SDHID1_3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CMD, CLK */
+	263, 258,
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SDHICMD1_MARK, SDHICLK1_MARK,
+};
+/* - SDHI2 ------------------------------------------------------------------ */
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	265,
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SDHID2_0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	265, 266, 267, 268,
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SDHID2_0_MARK, SDHID2_1_MARK, SDHID2_2_MARK, SDHID2_3_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CMD, CLK */
+	269, 264,
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SDHICMD2_MARK, SDHICLK2_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(fsia_mclk_in),
@@ -2563,6 +2703,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd2_sync_1),
 	SH_PFC_PIN_GROUP(lcd2_sys_0),
 	SH_PFC_PIN_GROUP(lcd2_sys_1),
+	SH_PFC_PIN_GROUP(mmc0_data1_0),
+	SH_PFC_PIN_GROUP(mmc0_data4_0),
+	SH_PFC_PIN_GROUP(mmc0_data8_0),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_0),
+	SH_PFC_PIN_GROUP(mmc0_data1_1),
+	SH_PFC_PIN_GROUP(mmc0_data4_1),
+	SH_PFC_PIN_GROUP(mmc0_data8_1),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
 	SH_PFC_PIN_GROUP(scifa0_data),
 	SH_PFC_PIN_GROUP(scifa0_clk),
 	SH_PFC_PIN_GROUP(scifa0_ctrl),
@@ -2597,6 +2745,17 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb_data_1),
 	SH_PFC_PIN_GROUP(scifb_clk_1),
 	SH_PFC_PIN_GROUP(scifb_ctrl_1),
+	SH_PFC_PIN_GROUP(sdhi0_data1),
+	SH_PFC_PIN_GROUP(sdhi0_data4),
+	SH_PFC_PIN_GROUP(sdhi0_ctrl),
+	SH_PFC_PIN_GROUP(sdhi0_cd),
+	SH_PFC_PIN_GROUP(sdhi0_wp),
+	SH_PFC_PIN_GROUP(sdhi1_data1),
+	SH_PFC_PIN_GROUP(sdhi1_data4),
+	SH_PFC_PIN_GROUP(sdhi1_ctrl),
+	SH_PFC_PIN_GROUP(sdhi2_data1),
+	SH_PFC_PIN_GROUP(sdhi2_data4),
+	SH_PFC_PIN_GROUP(sdhi2_ctrl),
 };
 
 static const char * const fsia_groups[] = {
@@ -2673,6 +2832,17 @@ static const char * const lcd2_groups[] = {
 	"lcd2_sys_1",
 };
 
+static const char * const mmc0_groups[] = {
+	"mmc0_data1_0",
+	"mmc0_data4_0",
+	"mmc0_data8_0",
+	"mmc0_ctrl_0",
+	"mmc0_data1_1",
+	"mmc0_data4_1",
+	"mmc0_data8_1",
+	"mmc0_ctrl_1",
+};
+
 static const char * const scifa0_groups[] = {
 	"scifa0_data",
 	"scifa0_clk",
@@ -2734,6 +2904,26 @@ static const char * const scifb_groups[] = {
 	"scifb_ctrl_1",
 };
 
+static const char * const sdhi0_groups[] = {
+	"sdhi0_data1",
+	"sdhi0_data4",
+	"sdhi0_ctrl",
+	"sdhi0_cd",
+	"sdhi0_wp",
+};
+
+static const char * const sdhi1_groups[] = {
+	"sdhi1_data1",
+	"sdhi1_data4",
+	"sdhi1_ctrl",
+};
+
+static const char * const sdhi2_groups[] = {
+	"sdhi2_data1",
+	"sdhi2_data4",
+	"sdhi2_ctrl",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(fsia),
 	SH_PFC_FUNCTION(fsib),
@@ -2743,6 +2933,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
+	SH_PFC_FUNCTION(mmc0),
 	SH_PFC_FUNCTION(scifa0),
 	SH_PFC_FUNCTION(scifa1),
 	SH_PFC_FUNCTION(scifa2),
@@ -2752,6 +2943,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifa6),
 	SH_PFC_FUNCTION(scifa7),
 	SH_PFC_FUNCTION(scifb),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
 };
 
 #define PINMUX_FN_BASE	GPIO_FN_VBUS_0
-- 
1.7.10.4
