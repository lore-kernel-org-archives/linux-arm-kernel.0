From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:45 +0100
Subject: [PATCH v3 2/8] pinctrl: add SDHI and MMCIF pin groups to sh7372
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin groups for all three SDHI interfaces and two alternative pin
groups for the MMCIF interface on the sh7372 SoC.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---

v3: fixed indentation.

 drivers/pinctrl/sh-pfc/pfc-sh7372.c |  205 +++++++++++++++++++++++++++++++++++
 1 files changed, 205 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 847e0cd..b4b54a0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -933,6 +933,206 @@ static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	173,
+};
+static const unsigned int sdhi0_data1_mux[] = {
+	SDHID0_0_MARK,
+};
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	173, 174, 175, 176,
+};
+static const unsigned int sdhi0_data4_mux[] = {
+	SDHID0_0_MARK, SDHID0_1_MARK, SDHID0_2_MARK, SDHID0_3_MARK,
+};
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CMD, CLK */
+	177, 171,
+};
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SDHICMD0_MARK, SDHICLK0_MARK,
+};
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	172,
+};
+static const unsigned int sdhi0_cd_mux[] = {
+	SDHICD0_MARK,
+};
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	178,
+};
+static const unsigned int sdhi0_wp_mux[] = {
+	SDHIWP0_MARK,
+};
+
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	180,
+};
+static const unsigned int sdhi1_data1_mux[] = {
+	SDHID1_0_MARK,
+};
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	180, 181, 182, 183,
+};
+static const unsigned int sdhi1_data4_mux[] = {
+	SDHID1_0_MARK, SDHID1_1_MARK, SDHID1_2_MARK, SDHID1_3_MARK,
+};
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CMD, CLK */
+	184, 179,
+};
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SDHICMD1_MARK, SDHICLK1_MARK,
+};
+
+static const unsigned int sdhi2_data1_pins[] = {
+	/* D0 */
+	186,
+};
+static const unsigned int sdhi2_data1_mux[] = {
+	SDHID2_0_MARK,
+};
+static const unsigned int sdhi2_data4_pins[] = {
+	/* D[0:3] */
+	186, 187, 188, 189,
+};
+static const unsigned int sdhi2_data4_mux[] = {
+	SDHID2_0_MARK, SDHID2_1_MARK, SDHID2_2_MARK, SDHID2_3_MARK,
+};
+static const unsigned int sdhi2_ctrl_pins[] = {
+	/* CMD, CLK */
+	190, 185,
+};
+static const unsigned int sdhi2_ctrl_mux[] = {
+	SDHICMD2_MARK, SDHICLK2_MARK,
+};
+
+static const unsigned int mmc0_data1_0_pins[] = {
+	/* D[0] */
+	84,
+};
+static const unsigned int mmc0_data1_0_mux[] = {
+	MMCD0_0_MARK,
+};
+static const unsigned int mmc0_data4_0_pins[] = {
+	/* D[0:3] */
+	84, 85, 86, 87,
+};
+static const unsigned int mmc0_data4_0_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+};
+static const unsigned int mmc0_data8_0_pins[] = {
+	/* D[0:7] */
+	84, 85, 86, 87, 88, 89, 90, 91,
+};
+static const unsigned int mmc0_data8_0_mux[] = {
+	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
+	MMCD0_4_MARK, MMCD0_5_MARK, MMCD0_6_MARK, MMCD0_7_MARK,
+};
+static const unsigned int mmc0_ctrl_0_pins[] = {
+	/* CMD, CLK */
+	92, 99,
+};
+static const unsigned int mmc0_ctrl_0_mux[] = {
+	MMCCMD0_MARK, MMCCLK0_MARK,
+};
+
+static const unsigned int mmc0_data1_1_pins[] = {
+	/* D[0] */
+	54,
+};
+static const unsigned int mmc0_data1_1_mux[] = {
+	MMCD1_0_MARK,
+};
+static const unsigned int mmc0_data4_1_pins[] = {
+	/* D[0:3] */
+	54, 55, 56, 57,
+};
+static const unsigned int mmc0_data4_1_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+};
+static const unsigned int mmc0_data8_1_pins[] = {
+	/* D[0:7] */
+	54, 55, 56, 57, 58, 59, 60, 61,
+};
+static const unsigned int mmc0_data8_1_mux[] = {
+	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
+	MMCD1_4_MARK, MMCD1_5_MARK, MMCD1_6_MARK, MMCD1_7_MARK,
+};
+static const unsigned int mmc0_ctrl_1_pins[] = {
+	/* CMD, CLK */
+	67, 66,
+};
+static const unsigned int mmc0_ctrl_1_mux[] = {
+	MMCCMD1_MARK, MMCCLK1_MARK,
+};
+
+static const struct sh_pfc_pin_group pinmux_groups[] = {
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
+	SH_PFC_PIN_GROUP(mmc0_data1_0),
+	SH_PFC_PIN_GROUP(mmc0_data4_0),
+	SH_PFC_PIN_GROUP(mmc0_data8_0),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_0),
+	SH_PFC_PIN_GROUP(mmc0_data1_1),
+	SH_PFC_PIN_GROUP(mmc0_data4_1),
+	SH_PFC_PIN_GROUP(mmc0_data8_1),
+	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
+};
+
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
+static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(sdhi0),
+	SH_PFC_FUNCTION(sdhi1),
+	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(mmc0),
+};
+
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static struct pinmux_func pinmux_func_gpios[] = {
@@ -1644,6 +1844,11 @@ struct sh_pfc_soc_info sh7372_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
 	.func_gpios = pinmux_func_gpios,
 	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
 
-- 
1.7.2.5
