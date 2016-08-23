From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Aug 2016 09:49:45 +0200
Subject: [PATCH/RFT v2 3/8] pinctrl: sh-pfc: r8a7796: Add SDHI pins,
 groups and functions
In-Reply-To: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
References: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1471938590-10650-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds SDHI pins, groups and functions to R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 275 +++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 939e3fcad011..e2a2185c2b74 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -1684,6 +1684,213 @@ static const unsigned int scif5_clk_b_mux[] = {
 	SCK5_B_MARK,
 };
 
+/* - SDHI0 ------------------------------------------------------------------ */
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(3, 2),
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SD0_DAT0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 5),
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SD0_DAT0_MARK, SD0_DAT1_MARK,
+	SD0_DAT2_MARK, SD0_DAT3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SD0_CLK_MARK, SD0_CMD_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(3, 12),
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SD0_CD_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(3, 13),
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SD0_WP_MARK,
+};
+/* - SDHI1 ------------------------------------------------------------------ */
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(3, 8),
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SD1_DAT0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(3, 8),  RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SD1_DAT0_MARK, SD1_DAT1_MARK,
+	SD1_DAT2_MARK, SD1_DAT3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SD1_CLK_MARK, SD1_CMD_MARK,
+};
+static const unsigned int sdhi1_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(3, 14),
+};
+static const unsigned int sdhi1_cd_mux[] = {
+	SD1_CD_MARK,
+};
+static const unsigned int sdhi1_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(3, 15),
+};
+static const unsigned int sdhi1_wp_mux[] = {
+	SD1_WP_MARK,
+};
+/* - SDHI2 ------------------------------------------------------------------ */
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(4, 2),
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SD2_DAT0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 3),
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SD2_DAT0_MARK, SD2_DAT1_MARK,
+	SD2_DAT2_MARK, SD2_DAT3_MARK,
+};
+static const unsigned int sdhi2_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(4, 2),  RCAR_GP_PIN(4, 3),
+	RCAR_GP_PIN(4, 4),  RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(3, 8),  RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+};
+static const unsigned int sdhi2_data8_mux[] = {
+	SD2_DAT0_MARK, SD2_DAT1_MARK,
+	SD2_DAT2_MARK, SD2_DAT3_MARK,
+	SD2_DAT4_MARK, SD2_DAT5_MARK,
+	SD2_DAT6_MARK, SD2_DAT7_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SD2_CLK_MARK, SD2_CMD_MARK,
+};
+static const unsigned int sdhi2_cd_a_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(4, 13),
+};
+static const unsigned int sdhi2_cd_a_mux[] = {
+	SD2_CD_A_MARK,
+};
+static const unsigned int sdhi2_cd_b_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(5, 10),
+};
+static const unsigned int sdhi2_cd_b_mux[] = {
+	SD2_CD_B_MARK,
+};
+static const unsigned int sdhi2_wp_a_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(4, 14),
+};
+static const unsigned int sdhi2_wp_a_mux[] = {
+	SD2_WP_A_MARK,
+};
+static const unsigned int sdhi2_wp_b_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(5, 11),
+};
+static const unsigned int sdhi2_wp_b_mux[] = {
+	SD2_WP_B_MARK,
+};
+static const unsigned int sdhi2_ds_pins[] = {
+	/* DS */
+	RCAR_GP_PIN(4, 6),
+};
+static const unsigned int sdhi2_ds_mux[] = {
+	SD2_DS_MARK,
+};
+/* - SDHI3 ------------------------------------------------------------------ */
+static const unsigned int sdhi3_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(4, 9),
+};
+static const unsigned int sdhi3_data1_mux[] = {
+	SD3_DAT0_MARK,
+};
+static const unsigned int sdhi3_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+};
+static const unsigned int sdhi3_data4_mux[] = {
+	SD3_DAT0_MARK, SD3_DAT1_MARK,
+	SD3_DAT2_MARK, SD3_DAT3_MARK,
+};
+static const unsigned int sdhi3_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
+	RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14),
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16),
+};
+static const unsigned int sdhi3_data8_mux[] = {
+	SD3_DAT0_MARK, SD3_DAT1_MARK,
+	SD3_DAT2_MARK, SD3_DAT3_MARK,
+	SD3_DAT4_MARK, SD3_DAT5_MARK,
+	SD3_DAT6_MARK, SD3_DAT7_MARK,
+};
+static const unsigned int sdhi3_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(4, 7), RCAR_GP_PIN(4, 8),
+};
+static const unsigned int sdhi3_ctrl_mux[] = {
+	SD3_CLK_MARK, SD3_CMD_MARK,
+};
+static const unsigned int sdhi3_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(4, 15),
+};
+static const unsigned int sdhi3_cd_mux[] = {
+	SD3_CD_MARK,
+};
+static const unsigned int sdhi3_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(4, 16),
+};
+static const unsigned int sdhi3_wp_mux[] = {
+	SD3_WP_MARK,
+};
+static const unsigned int sdhi3_ds_pins[] = {
+	/* DS */
+	RCAR_GP_PIN(4, 17),
+};
+static const unsigned int sdhi3_ds_mux[] = {
+	SD3_DS_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
@@ -1712,6 +1919,32 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif5_clk_a),
 	SH_PFC_PIN_GROUP(scif5_data_b),
 	SH_PFC_PIN_GROUP(scif5_clk_b),
+	SH_PFC_PIN_GROUP(sdhi0_data1),
+	SH_PFC_PIN_GROUP(sdhi0_data4),
+	SH_PFC_PIN_GROUP(sdhi0_ctrl),
+	SH_PFC_PIN_GROUP(sdhi0_cd),
+	SH_PFC_PIN_GROUP(sdhi0_wp),
+	SH_PFC_PIN_GROUP(sdhi1_data1),
+	SH_PFC_PIN_GROUP(sdhi1_data4),
+	SH_PFC_PIN_GROUP(sdhi1_ctrl),
+	SH_PFC_PIN_GROUP(sdhi1_cd),
+	SH_PFC_PIN_GROUP(sdhi1_wp),
+	SH_PFC_PIN_GROUP(sdhi2_data1),
+	SH_PFC_PIN_GROUP(sdhi2_data4),
+	SH_PFC_PIN_GROUP(sdhi2_data8),
+	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(sdhi2_cd_a),
+	SH_PFC_PIN_GROUP(sdhi2_wp_a),
+	SH_PFC_PIN_GROUP(sdhi2_cd_b),
+	SH_PFC_PIN_GROUP(sdhi2_wp_b),
+	SH_PFC_PIN_GROUP(sdhi2_ds),
+	SH_PFC_PIN_GROUP(sdhi3_data1),
+	SH_PFC_PIN_GROUP(sdhi3_data4),
+	SH_PFC_PIN_GROUP(sdhi3_data8),
+	SH_PFC_PIN_GROUP(sdhi3_ctrl),
+	SH_PFC_PIN_GROUP(sdhi3_cd),
+	SH_PFC_PIN_GROUP(sdhi3_wp),
+	SH_PFC_PIN_GROUP(sdhi3_ds),
 };
 
 static const char * const scif0_groups[] = {
@@ -1759,6 +1992,44 @@ static const char * const scif5_groups[] = {
 	"scif5_clk_b",
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
+	"sdhi1_cd",
+	"sdhi1_wp",
+};
+
+static const char * const sdhi2_groups[] = {
+	"sdhi2_data1",
+	"sdhi2_data4",
+	"sdhi2_data8",
+	"sdhi2_ctrl",
+	"sdhi2_cd_a",
+	"sdhi2_wp_a",
+	"sdhi2_cd_b",
+	"sdhi2_wp_b",
+	"sdhi2_ds",
+};
+
+static const char * const sdhi3_groups[] = {
+	"sdhi3_data1",
+	"sdhi3_data4",
+	"sdhi3_data8",
+	"sdhi3_ctrl",
+	"sdhi3_cd",
+	"sdhi3_wp",
+	"sdhi3_ds",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
@@ -1766,6 +2037,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(sdhi3),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.7.0.rc3.207.g0ac5344
