From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed,  5 Sep 2018 05:21:37 +0900
Subject: [PATCH/RFT] pinctrl: sh-pfc: r8a77995: Add MSIOF pins,
 groups and functions
Message-ID: <1536092497-5896-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds MSIOF{0,1,2,3} pins, groups and functions to R8A77995 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 365 ++++++++++++++++++++++++++++++++++
 1 file changed, 365 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index adade5b..b290982 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -520,6 +520,10 @@ enum {
 	PINMUX_SINGLE(QSPI0_SPCLK),
 	PINMUX_SINGLE(SCL0),
 	PINMUX_SINGLE(SDA0),
+	PINMUX_SINGLE(MSIOF0_RXD),
+	PINMUX_SINGLE(MSIOF0_TXD),
+	PINMUX_SINGLE(MSIOF0_SYNC),
+	PINMUX_SINGLE(MSIOF0_SCK),
 
 	/* IPSR0 */
 	PINMUX_IPSR_MSEL(IP0_3_0,	IRQ0_A, SEL_IRQ_0_0),
@@ -1277,6 +1281,289 @@ enum {
 	MMC_CLK_MARK, MMC_CMD_MARK,
 };
 
+/* - MSIOF0 ----------------------------------------------------------------- */
+static const unsigned int msiof0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 12),
+};
+
+static const unsigned int msiof0_clk_mux[] = {
+	MSIOF0_SCK_MARK,
+};
+
+static const unsigned int msiof0_sync_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(4, 13),
+};
+
+static const unsigned int msiof0_sync_mux[] = {
+	MSIOF0_SYNC_MARK,
+};
+
+static const unsigned int msiof0_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(4, 20),
+};
+
+static const unsigned int msiof0_ss1_mux[] = {
+	MSIOF0_SS1_MARK,
+};
+
+static const unsigned int msiof0_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(4, 21),
+};
+
+static const unsigned int msiof0_ss2_mux[] = {
+	MSIOF0_SS2_MARK,
+};
+
+static const unsigned int msiof0_txd_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(4, 14),
+};
+
+static const unsigned int msiof0_txd_mux[] = {
+	MSIOF0_TXD_MARK,
+};
+
+static const unsigned int msiof0_rxd_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(4, 15),
+};
+
+static const unsigned int msiof0_rxd_mux[] = {
+	MSIOF0_RXD_MARK,
+};
+
+/* - MSIOF1 ----------------------------------------------------------------- */
+static const unsigned int msiof1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(4, 16),
+};
+
+static const unsigned int msiof1_clk_mux[] = {
+	MSIOF1_SCK_MARK,
+};
+
+static const unsigned int msiof1_sync_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(4, 19),
+};
+
+static const unsigned int msiof1_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(4, 25),
+};
+
+static const unsigned int msiof1_ss1_mux[] = {
+	MSIOF1_SS1_MARK,
+};
+
+static const unsigned int msiof1_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(4, 22),
+};
+
+static const unsigned int msiof1_ss2_mux[] = {
+	MSIOF1_SS2_MARK,
+};
+
+static const unsigned int msiof1_sync_mux[] = {
+	MSIOF1_SYNC_MARK,
+};
+
+static const unsigned int msiof1_txd_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(4, 17),
+};
+
+static const unsigned int msiof1_txd_mux[] = {
+	MSIOF1_TXD_MARK,
+};
+
+static const unsigned int msiof1_rxd_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(4, 18),
+};
+
+static const unsigned int msiof1_rxd_mux[] = {
+	MSIOF1_RXD_MARK,
+};
+
+/* - MSIOF2 ----------------------------------------------------------------- */
+static const unsigned int msiof2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 3),
+};
+
+static const unsigned int msiof2_clk_mux[] = {
+	MSIOF2_SCK_MARK,
+};
+
+static const unsigned int msiof2_sync_a_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(0, 6),
+};
+
+static const unsigned int msiof2_sync_a_mux[] = {
+	MSIOF2_SYNC_A_MARK,
+};
+
+static const unsigned int msiof2_ss1_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(0, 7),
+};
+
+static const unsigned int msiof2_ss1_mux[] = {
+	MSIOF2_SS1_MARK,
+};
+
+static const unsigned int msiof2_ss2_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(0, 8),
+};
+
+static const unsigned int msiof2_ss2_mux[] = {
+	MSIOF2_SS2_MARK,
+};
+
+static const unsigned int msiof2_sync_b_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(0, 2),
+};
+
+static const unsigned int msiof2_sync_b_mux[] = {
+	MSIOF2_SYNC_B_MARK,
+};
+
+static const unsigned int msiof2_txd_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(0, 4),
+};
+
+static const unsigned int msiof2_txd_mux[] = {
+	MSIOF2_TXD_MARK,
+};
+
+static const unsigned int msiof2_rxd_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(0, 5),
+};
+
+static const unsigned int msiof2_rxd_mux[] = {
+	MSIOF2_RXD_MARK,
+};
+
+/* - MSIOF3 ----------------------------------------------------------------- */
+static const unsigned int msiof3_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 24),
+};
+
+static const unsigned int msiof3_clk_a_mux[] = {
+	MSIOF3_SCK_A_MARK,
+};
+
+static const unsigned int msiof3_sync_a_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(2, 21),
+};
+
+static const unsigned int msiof3_sync_a_mux[] = {
+	MSIOF3_SYNC_A_MARK,
+};
+
+static const unsigned int msiof3_ss1_a_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(2, 14),
+};
+
+static const unsigned int msiof3_ss1_a_mux[] = {
+	MSIOF3_SS1_A_MARK,
+};
+
+static const unsigned int msiof3_ss2_a_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(2, 10),
+};
+
+static const unsigned int msiof3_ss2_a_mux[] = {
+	MSIOF3_SS2_A_MARK,
+};
+
+static const unsigned int msiof3_txd_a_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(2, 22),
+};
+
+static const unsigned int msiof3_txd_a_mux[] = {
+	MSIOF3_TXD_A_MARK,
+};
+
+static const unsigned int msiof3_rxd_a_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(2, 23),
+};
+
+static const unsigned int msiof3_rxd_a_mux[] = {
+	MSIOF3_RXD_A_MARK,
+};
+
+static const unsigned int msiof3_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 8),
+};
+
+static const unsigned int msiof3_clk_b_mux[] = {
+	MSIOF3_SCK_B_MARK,
+};
+
+static const unsigned int msiof3_sync_b_pins[] = {
+	/* SYNC */
+	RCAR_GP_PIN(1, 9),
+};
+
+static const unsigned int msiof3_sync_b_mux[] = {
+	MSIOF3_SYNC_B_MARK,
+};
+
+static const unsigned int msiof3_ss1_b_pins[] = {
+	/* SS1 */
+	RCAR_GP_PIN(1, 6),
+};
+
+static const unsigned int msiof3_ss1_b_mux[] = {
+	MSIOF3_SS1_B_MARK,
+};
+
+static const unsigned int msiof3_ss2_b_pins[] = {
+	/* SS2 */
+	RCAR_GP_PIN(1, 7),
+};
+
+static const unsigned int msiof3_ss2_b_mux[] = {
+	MSIOF3_SS2_B_MARK,
+};
+
+static const unsigned int msiof3_txd_b_pins[] = {
+	/* TXD */
+	RCAR_GP_PIN(1, 0),
+};
+
+static const unsigned int msiof3_txd_b_mux[] = {
+	MSIOF3_TXD_B_MARK,
+};
+
+static const unsigned int msiof3_rxd_b_pins[] = {
+	/* RXD */
+	RCAR_GP_PIN(1, 1),
+};
+
+static const unsigned int msiof3_rxd_b_mux[] = {
+	MSIOF3_RXD_B_MARK,
+};
+
 /* - PWM0 ------------------------------------------------------------------ */
 static const unsigned int pwm0_a_pins[] = {
 	/* PWM */
@@ -1752,6 +2039,37 @@ enum {
 	SH_PFC_PIN_GROUP(mmc_data4),
 	SH_PFC_PIN_GROUP(mmc_data8),
 	SH_PFC_PIN_GROUP(mmc_ctrl),
+	SH_PFC_PIN_GROUP(msiof0_clk),
+	SH_PFC_PIN_GROUP(msiof0_sync),
+	SH_PFC_PIN_GROUP(msiof0_ss1),
+	SH_PFC_PIN_GROUP(msiof0_ss2),
+	SH_PFC_PIN_GROUP(msiof0_rxd),
+	SH_PFC_PIN_GROUP(msiof0_txd),
+	SH_PFC_PIN_GROUP(msiof1_clk),
+	SH_PFC_PIN_GROUP(msiof1_sync),
+	SH_PFC_PIN_GROUP(msiof1_ss1),
+	SH_PFC_PIN_GROUP(msiof1_ss2),
+	SH_PFC_PIN_GROUP(msiof1_rxd),
+	SH_PFC_PIN_GROUP(msiof1_txd),
+	SH_PFC_PIN_GROUP(msiof2_clk),
+	SH_PFC_PIN_GROUP(msiof2_sync_a),
+	SH_PFC_PIN_GROUP(msiof2_ss1),
+	SH_PFC_PIN_GROUP(msiof2_ss2),
+	SH_PFC_PIN_GROUP(msiof2_sync_b),
+	SH_PFC_PIN_GROUP(msiof2_rxd),
+	SH_PFC_PIN_GROUP(msiof2_txd),
+	SH_PFC_PIN_GROUP(msiof3_clk_a),
+	SH_PFC_PIN_GROUP(msiof3_sync_a),
+	SH_PFC_PIN_GROUP(msiof3_ss1_a),
+	SH_PFC_PIN_GROUP(msiof3_ss2_a),
+	SH_PFC_PIN_GROUP(msiof3_txd_a),
+	SH_PFC_PIN_GROUP(msiof3_rxd_a),
+	SH_PFC_PIN_GROUP(msiof3_clk_b),
+	SH_PFC_PIN_GROUP(msiof3_sync_b),
+	SH_PFC_PIN_GROUP(msiof3_ss1_b),
+	SH_PFC_PIN_GROUP(msiof3_ss2_b),
+	SH_PFC_PIN_GROUP(msiof3_rxd_b),
+	SH_PFC_PIN_GROUP(msiof3_txd_b),
 	SH_PFC_PIN_GROUP(pwm0_a),
 	SH_PFC_PIN_GROUP(pwm0_b),
 	SH_PFC_PIN_GROUP(pwm0_c),
@@ -1982,6 +2300,49 @@ enum {
 	"vin4_clk",
 };
 
+static const char * const msiof0_groups[] = {
+	"msiof0_clk",
+	"msiof0_sync",
+	"msiof0_ss1",
+	"msiof0_ss2",
+	"msiof0_rxd",
+	"msiof0_txd",
+};
+
+static const char * const msiof1_groups[] = {
+	"msiof1_clk",
+	"msiof1_sync",
+	"msiof1_ss1",
+	"msiof1_ss2",
+	"msiof1_rxd",
+	"msiof1_txd",
+};
+
+static const char * const msiof2_groups[] = {
+	"msiof2_clk",
+	"msiof2_sync_a",
+	"msiof2_ss1",
+	"msiof2_ss2",
+	"msiof2_sync_b",
+	"msiof2_rxd",
+	"msiof2_txd",
+};
+
+static const char * const msiof3_groups[] = {
+	"msiof3_clk_a",
+	"msiof3_sync_a",
+	"msiof3_ss1_a",
+	"msiof3_ss2_a",
+	"msiof3_txd_a",
+	"msiof3_rxd_a",
+	"msiof3_clk_b",
+	"msiof3_sync_b",
+	"msiof3_ss1_b",
+	"msiof3_ss2_b",
+	"msiof3_rxd_b",
+	"msiof3_txd_b",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb0),
@@ -1996,6 +2357,10 @@ enum {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(mmc),
+	SH_PFC_FUNCTION(msiof0),
+	SH_PFC_FUNCTION(msiof1),
+	SH_PFC_FUNCTION(msiof2),
+	SH_PFC_FUNCTION(msiof3),
 	SH_PFC_FUNCTION(pwm0),
 	SH_PFC_FUNCTION(pwm1),
 	SH_PFC_FUNCTION(pwm2),
-- 
1.9.1
