From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:17 +0900
Subject: [PATCH 026/130] sh-pfc: sh7372: Add FSI pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-27-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 91 +++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 9948699..641f6ee 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1113,6 +1113,71 @@ static const unsigned int flctl_ctrl_pins[] = {
 static const unsigned int flctl_ctrl_mux[] = {
 	A5_FCDE_MARK, A4_FOE_MARK, RD_FSC_MARK, WE0_FWE_MARK, FRB_MARK,
 };
+/* - FSIA ------------------------------------------------------------------- */
+static const unsigned int fsia_mclk_in_pins[] = {
+	/* CK */
+	4,
+};
+static const unsigned int fsia_mclk_in_mux[] = {
+	FSIACK_MARK,
+};
+static const unsigned int fsia_mclk_out_pins[] = {
+	/* OMC */
+	8,
+};
+static const unsigned int fsia_mclk_out_mux[] = {
+	FSIAOMC_MARK,
+};
+static const unsigned int fsia_sclk_in_pins[] = {
+	/* ILR, IBT */
+	5, 6,
+};
+static const unsigned int fsia_sclk_in_mux[] = {
+	FSIAILR_MARK, FSIAIBT_MARK,
+};
+static const unsigned int fsia_sclk_out_pins[] = {
+	/* OLR, OBT */
+	9, 10,
+};
+static const unsigned int fsia_sclk_out_mux[] = {
+	FSIAOLR_MARK, FSIAOBT_MARK,
+};
+static const unsigned int fsia_data_in_pins[] = {
+	/* ISLD */
+	7,
+};
+static const unsigned int fsia_data_in_mux[] = {
+	FSIAISLD_MARK,
+};
+static const unsigned int fsia_data_out_pins[] = {
+	/* OSLD */
+	11,
+};
+static const unsigned int fsia_data_out_mux[] = {
+	FSIAOSLD_MARK,
+};
+static const unsigned int fsia_spdif_0_pins[] = {
+	/* SPDIF */
+	11,
+};
+static const unsigned int fsia_spdif_0_mux[] = {
+	FSIASPDIF_11_MARK,
+};
+static const unsigned int fsia_spdif_1_pins[] = {
+	/* SPDIF */
+	15,
+};
+static const unsigned int fsia_spdif_1_mux[] = {
+	FSIASPDIF_15_MARK,
+};
+/* - FSIB ------------------------------------------------------------------- */
+static const unsigned int fsib_mclk_in_pins[] = {
+	/* CK */
+	4,
+};
+static const unsigned int fsib_mclk_in_mux[] = {
+	FSIBCK_MARK,
+};
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc0_data1_0_pins[] = {
 	/* D[0] */
@@ -1278,6 +1343,15 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(flctl_ce0),
 	SH_PFC_PIN_GROUP(flctl_ce1),
 	SH_PFC_PIN_GROUP(flctl_ctrl),
+	SH_PFC_PIN_GROUP(fsia_mclk_in),
+	SH_PFC_PIN_GROUP(fsia_mclk_out),
+	SH_PFC_PIN_GROUP(fsia_sclk_in),
+	SH_PFC_PIN_GROUP(fsia_sclk_out),
+	SH_PFC_PIN_GROUP(fsia_data_in),
+	SH_PFC_PIN_GROUP(fsia_data_out),
+	SH_PFC_PIN_GROUP(fsia_spdif_0),
+	SH_PFC_PIN_GROUP(fsia_spdif_1),
+	SH_PFC_PIN_GROUP(fsib_mclk_in),
 	SH_PFC_PIN_GROUP(mmc0_data1_0),
 	SH_PFC_PIN_GROUP(mmc0_data4_0),
 	SH_PFC_PIN_GROUP(mmc0_data8_0),
@@ -1331,6 +1405,21 @@ static const char * const flctl_groups[] = {
 	"flctl_ctrl",
 };
 
+static const char * const fsia_groups[] = {
+	"fsia_mclk_in",
+	"fsia_mclk_out",
+	"fsia_sclk_in",
+	"fsia_sclk_out",
+	"fsia_data_in",
+	"fsia_data_out",
+	"fsia_spdif_0",
+	"fsia_spdif_1",
+};
+
+static const char * const fsib_groups[] = {
+	"fsib_mclk_in",
+};
+
 static const char * const mmc0_groups[] = {
 	"mmc0_data1_0",
 	"mmc0_data4_0",
@@ -1366,6 +1455,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(ceu),
 	SH_PFC_FUNCTION(flctl),
+	SH_PFC_FUNCTION(fsia),
+	SH_PFC_FUNCTION(fsib),
 	SH_PFC_FUNCTION(mmc0),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
-- 
1.8.2.1
