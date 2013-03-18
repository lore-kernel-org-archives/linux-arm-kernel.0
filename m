From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:54 +0900
Subject: [PATCH 058/142] sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and
 functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-59-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  351 +++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index c8b2604..4b0a349 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2040,6 +2040,253 @@ static const unsigned int lcd2_sys_1_mux[] = {
 	PORT221_LCD2CS__MARK, PORT219_LCD2WR__MARK,
 	LCD2RD__MARK, PORT217_LCD2RS_MARK,
 };
+/* - SCIFA0 ----------------------------------------------------------------- */
+static const unsigned int scifa0_data_pins[] = {
+	/* RXD, TXD */
+	43, 17,
+};
+static const unsigned int scifa0_data_mux[] = {
+	SCIFA0_RXD_MARK, SCIFA0_TXD_MARK,
+};
+static const unsigned int scifa0_clk_pins[] = {
+	/* SCK */
+	16,
+};
+static const unsigned int scifa0_clk_mux[] = {
+	SCIFA0_SCK_MARK,
+};
+static const unsigned int scifa0_ctrl_pins[] = {
+	/* RTS, CTS */
+	42, 44,
+};
+static const unsigned int scifa0_ctrl_mux[] = {
+	SCIFA0_RTS__MARK, SCIFA0_CTS__MARK,
+};
+/* - SCIFA1 ----------------------------------------------------------------- */
+static const unsigned int scifa1_data_pins[] = {
+	/* RXD, TXD */
+	228, 225,
+};
+static const unsigned int scifa1_data_mux[] = {
+	SCIFA1_RXD_MARK, SCIFA1_TXD_MARK,
+};
+static const unsigned int scifa1_clk_pins[] = {
+	/* SCK */
+	226,
+};
+static const unsigned int scifa1_clk_mux[] = {
+	SCIFA1_SCK_MARK,
+};
+static const unsigned int scifa1_ctrl_pins[] = {
+	/* RTS, CTS */
+	227, 229,
+};
+static const unsigned int scifa1_ctrl_mux[] = {
+	SCIFA1_RTS__MARK, SCIFA1_CTS__MARK,
+};
+/* - SCIFA2 ----------------------------------------------------------------- */
+static const unsigned int scifa2_data_0_pins[] = {
+	/* RXD, TXD */
+	155, 154,
+};
+static const unsigned int scifa2_data_0_mux[] = {
+	SCIFA2_RXD1_MARK, SCIFA2_TXD1_MARK,
+};
+static const unsigned int scifa2_clk_0_pins[] = {
+	/* SCK */
+	158,
+};
+static const unsigned int scifa2_clk_0_mux[] = {
+	SCIFA2_SCK1_MARK,
+};
+static const unsigned int scifa2_ctrl_0_pins[] = {
+	/* RTS, CTS */
+	156, 157,
+};
+static const unsigned int scifa2_ctrl_0_mux[] = {
+	SCIFA2_RTS1__MARK, SCIFA2_CTS1__MARK,
+};
+static const unsigned int scifa2_data_1_pins[] = {
+	/* RXD, TXD */
+	233, 230,
+};
+static const unsigned int scifa2_data_1_mux[] = {
+	SCIFA2_RXD2_MARK, SCIFA2_TXD2_MARK,
+};
+static const unsigned int scifa2_clk_1_pins[] = {
+	/* SCK */
+	232,
+};
+static const unsigned int scifa2_clk_1_mux[] = {
+	SCIFA2_SCK2_MARK,
+};
+static const unsigned int scifa2_ctrl_1_pins[] = {
+	/* RTS, CTS */
+	234, 231,
+};
+static const unsigned int scifa2_ctrl_1_mux[] = {
+	SCIFA2_RTS2__MARK, SCIFA2_CTS2__MARK,
+};
+/* - SCIFA3 ----------------------------------------------------------------- */
+static const unsigned int scifa3_data_pins[] = {
+	/* RXD, TXD */
+	108, 110,
+};
+static const unsigned int scifa3_data_mux[] = {
+	SCIFA3_RXD_MARK, SCIFA3_TXD_MARK,
+};
+static const unsigned int scifa3_ctrl_pins[] = {
+	/* RTS, CTS */
+	109, 107,
+};
+static const unsigned int scifa3_ctrl_mux[] = {
+	SCIFA3_RTS__MARK, SCIFA3_CTS__MARK,
+};
+/* - SCIFA4 ----------------------------------------------------------------- */
+static const unsigned int scifa4_data_pins[] = {
+	/* RXD, TXD */
+	33, 32,
+};
+static const unsigned int scifa4_data_mux[] = {
+	SCIFA4_RXD_MARK, SCIFA4_TXD_MARK,
+};
+static const unsigned int scifa4_ctrl_pins[] = {
+	/* RTS, CTS */
+	34, 35,
+};
+static const unsigned int scifa4_ctrl_mux[] = {
+	SCIFA4_RTS__MARK, SCIFA4_CTS__MARK,
+};
+/* - SCIFA5 ----------------------------------------------------------------- */
+static const unsigned int scifa5_data_0_pins[] = {
+	/* RXD, TXD */
+	246, 247,
+};
+static const unsigned int scifa5_data_0_mux[] = {
+	PORT246_SCIFA5_RXD_MARK, PORT247_SCIFA5_TXD_MARK,
+};
+static const unsigned int scifa5_clk_0_pins[] = {
+	/* SCK */
+	248,
+};
+static const unsigned int scifa5_clk_0_mux[] = {
+	PORT248_SCIFA5_SCK_MARK,
+};
+static const unsigned int scifa5_ctrl_0_pins[] = {
+	/* RTS, CTS */
+	245, 244,
+};
+static const unsigned int scifa5_ctrl_0_mux[] = {
+	PORT245_SCIFA5_RTS__MARK, PORT244_SCIFA5_CTS__MARK,
+};
+static const unsigned int scifa5_data_1_pins[] = {
+	/* RXD, TXD */
+	195, 196,
+};
+static const unsigned int scifa5_data_1_mux[] = {
+	PORT195_SCIFA5_RXD_MARK, PORT196_SCIFA5_TXD_MARK,
+};
+static const unsigned int scifa5_clk_1_pins[] = {
+	/* SCK */
+	197,
+};
+static const unsigned int scifa5_clk_1_mux[] = {
+	PORT197_SCIFA5_SCK_MARK,
+};
+static const unsigned int scifa5_ctrl_1_pins[] = {
+	/* RTS, CTS */
+	194, 193,
+};
+static const unsigned int scifa5_ctrl_1_mux[] = {
+	PORT194_SCIFA5_RTS__MARK, PORT193_SCIFA5_CTS__MARK,
+};
+static const unsigned int scifa5_data_2_pins[] = {
+	/* RXD, TXD */
+	162, 160,
+};
+static const unsigned int scifa5_data_2_mux[] = {
+	PORT162_SCIFA5_RXD_MARK, PORT160_SCIFA5_TXD_MARK,
+};
+static const unsigned int scifa5_clk_2_pins[] = {
+	/* SCK */
+	159,
+};
+static const unsigned int scifa5_clk_2_mux[] = {
+	PORT159_SCIFA5_SCK_MARK,
+};
+static const unsigned int scifa5_ctrl_2_pins[] = {
+	/* RTS, CTS */
+	163, 161,
+};
+static const unsigned int scifa5_ctrl_2_mux[] = {
+	PORT163_SCIFA5_RTS__MARK, PORT161_SCIFA5_CTS__MARK,
+};
+/* - SCIFA6 ----------------------------------------------------------------- */
+static const unsigned int scifa6_pins[] = {
+	/* TXD */
+	240,
+};
+static const unsigned int scifa6_mux[] = {
+	SCIFA6_TXD_MARK,
+};
+/* - SCIFA7 ----------------------------------------------------------------- */
+static const unsigned int scifa7_data_pins[] = {
+	/* RXD, TXD */
+	12, 18,
+};
+static const unsigned int scifa7_data_mux[] = {
+	SCIFA7_RXD_MARK, SCIFA7_TXD_MARK,
+};
+static const unsigned int scifa7_ctrl_pins[] = {
+	/* RTS, CTS */
+	19, 13,
+};
+static const unsigned int scifa7_ctrl_mux[] = {
+	SCIFA7_RTS__MARK, SCIFA7_CTS__MARK,
+};
+/* - SCIFB ------------------------------------------------------------------ */
+static const unsigned int scifb_data_0_pins[] = {
+	/* RXD, TXD */
+	162, 160,
+};
+static const unsigned int scifb_data_0_mux[] = {
+	PORT162_SCIFB_RXD_MARK, PORT160_SCIFB_TXD_MARK,
+};
+static const unsigned int scifb_clk_0_pins[] = {
+	/* SCK */
+	159,
+};
+static const unsigned int scifb_clk_0_mux[] = {
+	PORT159_SCIFB_SCK_MARK,
+};
+static const unsigned int scifb_ctrl_0_pins[] = {
+	/* RTS, CTS */
+	163, 161,
+};
+static const unsigned int scifb_ctrl_0_mux[] = {
+	PORT163_SCIFB_RTS__MARK, PORT161_SCIFB_CTS__MARK,
+};
+static const unsigned int scifb_data_1_pins[] = {
+	/* RXD, TXD */
+	246, 247,
+};
+static const unsigned int scifb_data_1_mux[] = {
+	PORT246_SCIFB_RXD_MARK, PORT247_SCIFB_TXD_MARK,
+};
+static const unsigned int scifb_clk_1_pins[] = {
+	/* SCK */
+	248,
+};
+static const unsigned int scifb_clk_1_mux[] = {
+	PORT248_SCIFB_SCK_MARK,
+};
+static const unsigned int scifb_ctrl_1_pins[] = {
+	/* RTS, CTS */
+	245, 244,
+};
+static const unsigned int scifb_ctrl_1_mux[] = {
+	PORT245_SCIFB_RTS__MARK, PORT244_SCIFB_CTS__MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd_data8),
@@ -2062,6 +2309,40 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd2_sync_1),
 	SH_PFC_PIN_GROUP(lcd2_sys_0),
 	SH_PFC_PIN_GROUP(lcd2_sys_1),
+	SH_PFC_PIN_GROUP(scifa0_data),
+	SH_PFC_PIN_GROUP(scifa0_clk),
+	SH_PFC_PIN_GROUP(scifa0_ctrl),
+	SH_PFC_PIN_GROUP(scifa1_data),
+	SH_PFC_PIN_GROUP(scifa1_clk),
+	SH_PFC_PIN_GROUP(scifa1_ctrl),
+	SH_PFC_PIN_GROUP(scifa2_data_0),
+	SH_PFC_PIN_GROUP(scifa2_clk_0),
+	SH_PFC_PIN_GROUP(scifa2_ctrl_0),
+	SH_PFC_PIN_GROUP(scifa2_data_1),
+	SH_PFC_PIN_GROUP(scifa2_clk_1),
+	SH_PFC_PIN_GROUP(scifa2_ctrl_1),
+	SH_PFC_PIN_GROUP(scifa3_data),
+	SH_PFC_PIN_GROUP(scifa3_ctrl),
+	SH_PFC_PIN_GROUP(scifa4_data),
+	SH_PFC_PIN_GROUP(scifa4_ctrl),
+	SH_PFC_PIN_GROUP(scifa5_data_0),
+	SH_PFC_PIN_GROUP(scifa5_clk_0),
+	SH_PFC_PIN_GROUP(scifa5_ctrl_0),
+	SH_PFC_PIN_GROUP(scifa5_data_1),
+	SH_PFC_PIN_GROUP(scifa5_clk_1),
+	SH_PFC_PIN_GROUP(scifa5_ctrl_1),
+	SH_PFC_PIN_GROUP(scifa5_data_2),
+	SH_PFC_PIN_GROUP(scifa5_clk_2),
+	SH_PFC_PIN_GROUP(scifa5_ctrl_2),
+	SH_PFC_PIN_GROUP(scifa6),
+	SH_PFC_PIN_GROUP(scifa7_data),
+	SH_PFC_PIN_GROUP(scifa7_ctrl),
+	SH_PFC_PIN_GROUP(scifb_data_0),
+	SH_PFC_PIN_GROUP(scifb_clk_0),
+	SH_PFC_PIN_GROUP(scifb_ctrl_0),
+	SH_PFC_PIN_GROUP(scifb_data_1),
+	SH_PFC_PIN_GROUP(scifb_clk_1),
+	SH_PFC_PIN_GROUP(scifb_ctrl_1),
 };
 
 static const char * const lcd_groups[] = {
@@ -2090,9 +2371,79 @@ static const char * const lcd2_groups[] = {
 	"lcd2_sys_1",
 };
 
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
+static const char * const scifa2_groups[] = {
+	"scifa2_data_0",
+	"scifa2_clk_0",
+	"scifa2_ctrl_0",
+	"scifa2_data_1",
+	"scifa2_clk_1",
+	"scifa2_ctrl_1",
+};
+
+static const char * const scifa3_groups[] = {
+	"scifa3_data",
+	"scifa3_ctrl",
+};
+
+static const char * const scifa4_groups[] = {
+	"scifa4_data",
+	"scifa4_ctrl",
+};
+
+static const char * const scifa5_groups[] = {
+	"scifa5_data_0",
+	"scifa5_clk_0",
+	"scifa5_ctrl_0",
+	"scifa5_data_1",
+	"scifa5_clk_1",
+	"scifa5_ctrl_1",
+	"scifa5_data_2",
+	"scifa5_clk_2",
+	"scifa5_ctrl_2",
+};
+
+static const char * const scifa6_groups[] = {
+	"scifa6",
+};
+
+static const char * const scifa7_groups[] = {
+	"scifa7_data",
+	"scifa7_ctrl",
+};
+
+static const char * const scifb_groups[] = {
+	"scifb_data_0",
+	"scifb_clk_0",
+	"scifb_ctrl_0",
+	"scifb_data_1",
+	"scifb_clk_1",
+	"scifb_ctrl_1",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
+	SH_PFC_FUNCTION(scifa0),
+	SH_PFC_FUNCTION(scifa1),
+	SH_PFC_FUNCTION(scifa2),
+	SH_PFC_FUNCTION(scifa3),
+	SH_PFC_FUNCTION(scifa4),
+	SH_PFC_FUNCTION(scifa5),
+	SH_PFC_FUNCTION(scifa6),
+	SH_PFC_FUNCTION(scifa7),
+	SH_PFC_FUNCTION(scifb),
 };
 
 #define PINMUX_FN_BASE	GPIO_FN_VBUS_0
-- 
1.7.10.4
