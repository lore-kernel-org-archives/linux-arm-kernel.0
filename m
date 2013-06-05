From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:18 +0900
Subject: [PATCH 027/130] sh-pfc: sh7372: Add HDMI pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-28-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 641f6ee..73b9e25 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1178,6 +1178,14 @@ static const unsigned int fsib_mclk_in_pins[] = {
 static const unsigned int fsib_mclk_in_mux[] = {
 	FSIBCK_MARK,
 };
+/* - HDMI ------------------------------------------------------------------- */
+static const unsigned int hdmi_pins[] = {
+	/* HPD, CEC */
+	169, 170,
+};
+static const unsigned int hdmi_mux[] = {
+	HDMI_HPD_MARK, HDMI_CEC_MARK,
+};
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc0_data1_0_pins[] = {
 	/* D[0] */
@@ -1352,6 +1360,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(fsia_spdif_0),
 	SH_PFC_PIN_GROUP(fsia_spdif_1),
 	SH_PFC_PIN_GROUP(fsib_mclk_in),
+	SH_PFC_PIN_GROUP(hdmi),
 	SH_PFC_PIN_GROUP(mmc0_data1_0),
 	SH_PFC_PIN_GROUP(mmc0_data4_0),
 	SH_PFC_PIN_GROUP(mmc0_data8_0),
@@ -1420,6 +1429,10 @@ static const char * const fsib_groups[] = {
 	"fsib_mclk_in",
 };
 
+static const char * const hdmi_groups[] = {
+	"hdmi",
+};
+
 static const char * const mmc0_groups[] = {
 	"mmc0_data1_0",
 	"mmc0_data4_0",
@@ -1457,6 +1470,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(flctl),
 	SH_PFC_FUNCTION(fsia),
 	SH_PFC_FUNCTION(fsib),
+	SH_PFC_FUNCTION(hdmi),
 	SH_PFC_FUNCTION(mmc0),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
-- 
1.8.2.1
