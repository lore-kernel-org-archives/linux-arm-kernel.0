From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:44 +0100
Subject: [PATCH v3 1/8] pinctrl: add SDHI and MMCIF pin groups to r8a7740
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-2-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin groups for the first two SDHI interfaces and two alternative pin
groups for the MMCIF interface on the r8a7740 SoC.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: swapped two pin numbers for MMCIF, as spotted by Laurent, thanks.

 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  248 ++++++++++++++++++++++++++++++++++
 1 files changed, 248 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index d0b7165..4c92af8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1870,6 +1870,188 @@ static const unsigned int lcd1_sys_mux[] = {
 	LCD1_CS_MARK, LCD1_WR_MARK, LCD1_RD_MARK, LCD1_RS_MARK,
 };
 
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	77,
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SDHI0_D0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	77, 78, 79, 80,
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SDHI0_D0_MARK, SDHI0_D1_MARK, SDHI0_D2_MARK, SDHI0_D3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CMD, CLK */
+	76, 82,
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SDHI0_CMD_MARK, SDHI0_CLK_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	81,
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SDHI0_CD_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	83,
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SDHI0_WP_MARK,
+};
+
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	68,
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SDHI1_D0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	68, 69, 70, 71,
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SDHI1_D0_MARK, SDHI1_D1_MARK, SDHI1_D2_MARK, SDHI1_D3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CMD, CLK */
+	67, 66,
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SDHI1_CMD_MARK, SDHI1_CLK_MARK,
+};
+static const unsigned int sdhi1_cd_pins[] = {
+	/* CD */
+	72,
+};
+static const unsigned int sdhi1_cd_mux[] = {
+	SDHI1_CD_MARK,
+};
+static const unsigned int sdhi1_wp_pins[] = {
+	/* WP */
+	73,
+};
+static const unsigned int sdhi1_wp_mux[] = {
+	SDHI1_WP_MARK,
+};
+
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	205,
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SDHI2_D0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	205, 206, 207, 208,
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SDHI2_D0_MARK, SDHI2_D1_MARK, SDHI2_D2_MARK, SDHI2_D3_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CMD, CLK */
+	204, 203,
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SDHI2_CMD_MARK, SDHI2_CLK_MARK,
+};
+static const unsigned int sdhi2_cd_0_pins[] = {
+	/* CD */
+	202,
+};
+static const unsigned int sdhi2_cd_0_mux[] = {
+	SDHI2_CD_PORT202_MARK,
+};
+static const unsigned int sdhi2_wp_0_pins[] = {
+	/* WP */
+	177,
+};
+static const unsigned int sdhi2_wp_0_mux[] = {
+	SDHI2_WP_PORT177_MARK,
+};
+static const unsigned int sdhi2_cd_1_pins[] = {
+	/* CD */
+	24,
+};
+static const unsigned int sdhi2_cd_1_mux[] = {
+	SDHI2_CD_PORT24_MARK,
+};
+static const unsigned int sdhi2_wp_1_pins[] = {
+	/* WP */
+	25,
+};
+static const unsigned int sdhi2_wp_1_mux[] = {
+	SDHI2_WP_PORT25_MARK,
+};
+
+static const unsigned int mmc0_data1_0_pins[] = {
+	/* D[0] */
+	68,
+};
+static const unsigned int mmc0_data1_0_mux[] = {
+	MMC0_D0_PORT68_MARK,
+};
+static const unsigned int mmc0_data4_0_pins[] = {
+	/* D[0:3] */
+	68, 69, 70, 71,
+};
+static const unsigned int mmc0_data4_0_mux[] = {
+	MMC0_D0_PORT68_MARK, MMC0_D1_PORT69_MARK, MMC0_D2_PORT70_MARK, MMC0_D3_PORT71_MARK,
+};
+static const unsigned int mmc0_data8_0_pins[] = {
+	/* D[0:7] */
+	68, 69, 70, 71, 72, 73, 74, 75,
+};
+static const unsigned int mmc0_data8_0_mux[] = {
+	MMC0_D0_PORT68_MARK, MMC0_D1_PORT69_MARK, MMC0_D2_PORT70_MARK, MMC0_D3_PORT71_MARK,
+	MMC0_D4_PORT72_MARK, MMC0_D5_PORT73_MARK, MMC0_D6_PORT74_MARK, MMC0_D7_PORT75_MARK,
+};
+static const unsigned int mmc0_ctrl_0_pins[] = {
+	/* CMD, CLK */
+	67, 66,
+};
+static const unsigned int mmc0_ctrl_0_mux[] = {
+	MMC0_CMD_PORT67_MARK, MMC0_CLK_PORT66_MARK,
+};
+
+static const unsigned int mmc0_data1_1_pins[] = {
+	/* D[0] */
+	149,
+};
+static const unsigned int mmc0_data1_1_mux[] = {
+	MMC1_D0_PORT149_MARK,
+};
+static const unsigned int mmc0_data4_1_pins[] = {
+	/* D[0:3] */
+	149, 148, 147, 146,
+};
+static const unsigned int mmc0_data4_1_mux[] = {
+	MMC1_D0_PORT149_MARK, MMC1_D1_PORT148_MARK, MMC1_D2_PORT147_MARK, MMC1_D3_PORT146_MARK,
+};
+static const unsigned int mmc0_data8_1_pins[] = {
+	/* D[0:7] */
+	149, 148, 147, 146, 145, 144, 143, 142,
+};
+static const unsigned int mmc0_data8_1_mux[] = {
+	MMC1_D0_PORT149_MARK, MMC1_D1_PORT148_MARK, MMC1_D2_PORT147_MARK, MMC1_D3_PORT146_MARK,
+	MMC1_D4_PORT145_MARK, MMC1_D5_PORT144_MARK, MMC1_D6_PORT143_MARK, MMC1_D7_PORT142_MARK,
+};
+static const unsigned int mmc0_ctrl_1_pins[] = {
+	/* CMD, CLK */
+	104, 103,
+};
+static const unsigned int mmc0_ctrl_1_mux[] = {
+	MMC1_CMD_PORT104_MARK, MMC1_CLK_PORT103_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd0_data8),
 	SH_PFC_PIN_GROUP(lcd0_data9),
@@ -1893,6 +2075,31 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(lcd1_lclk),
 	SH_PFC_PIN_GROUP(lcd1_sync),
 	SH_PFC_PIN_GROUP(lcd1_sys),
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
+	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(sdhi2_cd_0),
+	SH_PFC_PIN_GROUP(sdhi2_wp_0),
+	SH_PFC_PIN_GROUP(sdhi2_cd_1),
+	SH_PFC_PIN_GROUP(sdhi2_wp_1),
+	SH_PFC_PIN_GROUP(mmc0_data1_0),
+	SH_PFC_PIN_GROUP(mmc0_data4_0),
+	SH_PFC_PIN_GROUP(mmc0_data8_0),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_0),
+	SH_PFC_PIN_GROUP(mmc0_data1_1),
+	SH_PFC_PIN_GROUP(mmc0_data4_1),
+	SH_PFC_PIN_GROUP(mmc0_data8_1),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
 };
 
 static const char * const lcd0_groups[] = {
@@ -1923,9 +2130,50 @@ static const char * const lcd1_groups[] = {
 	"lcd1_sys",
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
+	"sdhi2_ctrl",
+	"sdhi2_cd_0",
+	"sdhi2_wp_0",
+	"sdhi2_cd_1",
+	"sdhi2_wp_1",
+};
+
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
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(lcd0),
 	SH_PFC_FUNCTION(lcd1),
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(mmc0),
 };
 
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
1.7.2.5
