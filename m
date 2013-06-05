From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:41 +0900
Subject: [PATCH 110/130] sh-pfc: r8a7740: Add TPU pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-111-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index e5ef587..f6ea47c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2745,6 +2745,42 @@ static const unsigned int sdhi2_wp_1_pins[] = {
 static const unsigned int sdhi2_wp_1_mux[] = {
 	SDHI2_WP_PORT25_MARK,
 };
+/* - TPU0 ------------------------------------------------------------------- */
+static const unsigned int tpu0_to0_pins[] = {
+	/* TO */
+	23,
+};
+static const unsigned int tpu0_to0_mux[] = {
+	TPU0TO0_MARK,
+};
+static const unsigned int tpu0_to1_pins[] = {
+	/* TO */
+	21,
+};
+static const unsigned int tpu0_to1_mux[] = {
+	TPU0TO1_MARK,
+};
+static const unsigned int tpu0_to2_0_pins[] = {
+	/* TO */
+	66,
+};
+static const unsigned int tpu0_to2_0_mux[] = {
+	TPU0TO2_PORT66_MARK,
+};
+static const unsigned int tpu0_to2_1_pins[] = {
+	/* TO */
+	202,
+};
+static const unsigned int tpu0_to2_1_mux[] = {
+	TPU0TO2_PORT202_MARK,
+};
+static const unsigned int tpu0_to3_pins[] = {
+	/* TO */
+	180,
+};
+static const unsigned int tpu0_to3_mux[] = {
+	TPU0TO3_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(bsc_data8),
@@ -2926,6 +2962,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_wp_0),
 	SH_PFC_PIN_GROUP(sdhi2_cd_1),
 	SH_PFC_PIN_GROUP(sdhi2_wp_1),
+	SH_PFC_PIN_GROUP(tpu0_to0),
+	SH_PFC_PIN_GROUP(tpu0_to1),
+	SH_PFC_PIN_GROUP(tpu0_to2_0),
+	SH_PFC_PIN_GROUP(tpu0_to2_1),
+	SH_PFC_PIN_GROUP(tpu0_to3),
 };
 
 static const char * const bsc_groups[] = {
@@ -3176,6 +3217,14 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_wp_1",
 };
 
+static const char * const tpu0_groups[] = {
+	"tpu0_to0",
+	"tpu0_to1",
+	"tpu0_to2_0",
+	"tpu0_to2_1",
+	"tpu0_to3",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(ceu0),
@@ -3200,6 +3249,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(tpu0),
 };
 
 #undef PORTCR
-- 
1.8.2.1
