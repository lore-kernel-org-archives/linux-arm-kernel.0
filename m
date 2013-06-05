From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:16 +0900
Subject: [PATCH 025/130] sh-pfc: sh7372: Add FLCTL pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-26-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 3da8319..9948699 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1081,6 +1081,38 @@ static const unsigned int ceu_field_pins[] = {
 static const unsigned int ceu_field_mux[] = {
 	VIO_FIELD_MARK,
 };
+/* - FLCTL ------------------------------------------------------------------ */
+static const unsigned int flctl_data_pins[] = {
+	/* NAF[0:15] */
+	46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
+};
+static const unsigned int flctl_data_mux[] = {
+	D0_NAF0_MARK, D1_NAF1_MARK, D2_NAF2_MARK, D3_NAF3_MARK,
+	D4_NAF4_MARK, D5_NAF5_MARK, D6_NAF6_MARK, D7_NAF7_MARK,
+	D8_NAF8_MARK, D9_NAF9_MARK, D10_NAF10_MARK, D11_NAF11_MARK,
+	D12_NAF12_MARK, D13_NAF13_MARK, D14_NAF14_MARK, D15_NAF15_MARK,
+};
+static const unsigned int flctl_ce0_pins[] = {
+	/* CE */
+	68,
+};
+static const unsigned int flctl_ce0_mux[] = {
+	FCE0_MARK,
+};
+static const unsigned int flctl_ce1_pins[] = {
+	/* CE */
+	66,
+};
+static const unsigned int flctl_ce1_mux[] = {
+	FCE1_MARK,
+};
+static const unsigned int flctl_ctrl_pins[] = {
+	/* FCDE, FOE, FSC, FWE, FRB */
+	24, 23, 69, 70, 73,
+};
+static const unsigned int flctl_ctrl_mux[] = {
+	A5_FCDE_MARK, A4_FOE_MARK, RD_FSC_MARK, WE0_FWE_MARK, FRB_MARK,
+};
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc0_data1_0_pins[] = {
 	/* D[0] */
@@ -1242,6 +1274,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ceu_clk_2),
 	SH_PFC_PIN_GROUP(ceu_sync),
 	SH_PFC_PIN_GROUP(ceu_field),
+	SH_PFC_PIN_GROUP(flctl_data),
+	SH_PFC_PIN_GROUP(flctl_ce0),
+	SH_PFC_PIN_GROUP(flctl_ce1),
+	SH_PFC_PIN_GROUP(flctl_ctrl),
 	SH_PFC_PIN_GROUP(mmc0_data1_0),
 	SH_PFC_PIN_GROUP(mmc0_data4_0),
 	SH_PFC_PIN_GROUP(mmc0_data8_0),
@@ -1288,6 +1324,13 @@ static const char * const ceu_groups[] = {
 	"ceu_field",
 };
 
+static const char * const flctl_groups[] = {
+	"flctl_data",
+	"flctl_ce0",
+	"flctl_ce1",
+	"flctl_ctrl",
+};
+
 static const char * const mmc0_groups[] = {
 	"mmc0_data1_0",
 	"mmc0_data4_0",
@@ -1322,6 +1365,7 @@ static const char * const sdhi2_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(ceu),
+	SH_PFC_FUNCTION(flctl),
 	SH_PFC_FUNCTION(mmc0),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
-- 
1.8.2.1
