From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:59 +0900
Subject: [PATCH 063/142] sh-pfc: sh73a0: Add BSC pin groups and functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-64-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  124 +++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index aad8004..76674af 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1852,6 +1852,100 @@ static const struct pinmux_range pinmux_ranges[] = {
  */
 #define PIN_NUMBER(row, col)		(1000+((row)-1)*34+(col)-1)
 
+/* - BSC -------------------------------------------------------------------- */
+static const unsigned int bsc_data_0_7_pins[] = {
+	/* D[0:7] */
+	74, 75, 76, 77, 78, 79, 80, 81,
+};
+static const unsigned int bsc_data_0_7_mux[] = {
+	D0_NAF0_MARK, D1_NAF1_MARK, D2_NAF2_MARK, D3_NAF3_MARK,
+	D4_NAF4_MARK, D5_NAF5_MARK, D6_NAF6_MARK, D7_NAF7_MARK,
+};
+static const unsigned int bsc_data_8_15_pins[] = {
+	/* D[8:15] */
+	82, 83, 84, 85, 86, 87, 88, 89,
+};
+static const unsigned int bsc_data_8_15_mux[] = {
+	D8_NAF8_MARK, D9_NAF9_MARK, D10_NAF10_MARK, D11_NAF11_MARK,
+	D12_NAF12_MARK, D13_NAF13_MARK, D14_NAF14_MARK, D15_NAF15_MARK,
+};
+static const unsigned int bsc_cs4_pins[] = {
+	/* CS */
+	90,
+};
+static const unsigned int bsc_cs4_mux[] = {
+	CS4__MARK,
+};
+static const unsigned int bsc_cs5_a_pins[] = {
+	/* CS */
+	91,
+};
+static const unsigned int bsc_cs5_a_mux[] = {
+	CS5A__MARK,
+};
+static const unsigned int bsc_cs5_b_pins[] = {
+	/* CS */
+	92,
+};
+static const unsigned int bsc_cs5_b_mux[] = {
+	CS5B__MARK,
+};
+static const unsigned int bsc_cs6_a_pins[] = {
+	/* CS */
+	94,
+};
+static const unsigned int bsc_cs6_a_mux[] = {
+	CS6A__MARK,
+};
+static const unsigned int bsc_cs6_b_pins[] = {
+	/* CS */
+	93,
+};
+static const unsigned int bsc_cs6_b_mux[] = {
+	CS6B__MARK,
+};
+static const unsigned int bsc_rd_pins[] = {
+	/* RD */
+	96,
+};
+static const unsigned int bsc_rd_mux[] = {
+	RD__FSC_MARK,
+};
+static const unsigned int bsc_rdwr_0_pins[] = {
+	/* RDWR */
+	91,
+};
+static const unsigned int bsc_rdwr_0_mux[] = {
+	PORT91_RDWR_MARK,
+};
+static const unsigned int bsc_rdwr_1_pins[] = {
+	/* RDWR */
+	97,
+};
+static const unsigned int bsc_rdwr_1_mux[] = {
+	RDWR_FWE_MARK,
+};
+static const unsigned int bsc_rdwr_2_pins[] = {
+	/* RDWR */
+	149,
+};
+static const unsigned int bsc_rdwr_2_mux[] = {
+	PORT149_RDWR_MARK,
+};
+static const unsigned int bsc_we0_pins[] = {
+	/* WE0 */
+	97,
+};
+static const unsigned int bsc_we0_mux[] = {
+	WE0__FWE_MARK,
+};
+static const unsigned int bsc_we1_pins[] = {
+	/* WE1 */
+	98,
+};
+static const unsigned int bsc_we1_mux[] = {
+	WE1__MARK,
+};
 /* - FSIA ------------------------------------------------------------------- */
 static const unsigned int fsia_mclk_in_pins[] = {
 	/* CK */
@@ -2817,6 +2911,19 @@ static const unsigned int sdhi2_ctrl_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(bsc_data_0_7),
+	SH_PFC_PIN_GROUP(bsc_data_8_15),
+	SH_PFC_PIN_GROUP(bsc_cs4),
+	SH_PFC_PIN_GROUP(bsc_cs5_a),
+	SH_PFC_PIN_GROUP(bsc_cs5_b),
+	SH_PFC_PIN_GROUP(bsc_cs6_a),
+	SH_PFC_PIN_GROUP(bsc_cs6_b),
+	SH_PFC_PIN_GROUP(bsc_rd),
+	SH_PFC_PIN_GROUP(bsc_rdwr_0),
+	SH_PFC_PIN_GROUP(bsc_rdwr_1),
+	SH_PFC_PIN_GROUP(bsc_rdwr_2),
+	SH_PFC_PIN_GROUP(bsc_we0),
+	SH_PFC_PIN_GROUP(bsc_we1),
 	SH_PFC_PIN_GROUP(fsia_mclk_in),
 	SH_PFC_PIN_GROUP(fsia_mclk_out),
 	SH_PFC_PIN_GROUP(fsia_sclk_in),
@@ -2945,6 +3052,22 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
 };
 
+static const char * const bsc_groups[] = {
+	"bsc_data_0_7",
+	"bsc_data_8_15",
+	"bsc_cs4",
+	"bsc_cs5_a",
+	"bsc_cs5_b",
+	"bsc_cs6_a",
+	"bsc_cs6_b",
+	"bsc_rd",
+	"bsc_rdwr_0",
+	"bsc_rdwr_1",
+	"bsc_rdwr_2",
+	"bsc_we0",
+	"bsc_we1",
+};
+
 static const char * const fsia_groups[] = {
 	"fsia_mclk_in",
 	"fsia_mclk_out",
@@ -3137,6 +3260,7 @@ static const char * const sdhi2_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(fsia),
 	SH_PFC_FUNCTION(fsib),
 	SH_PFC_FUNCTION(fsic),
-- 
1.7.10.4
