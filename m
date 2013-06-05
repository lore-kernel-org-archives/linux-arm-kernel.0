From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:42 +0900
Subject: [PATCH 111/130] sh-pfc: r8a7790: Add TPU pin groups and functions
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-112-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 1656915..5be2999 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2342,6 +2342,35 @@ static const unsigned int scifb2_data_c_pins[] = {
 static const unsigned int scifb2_data_c_mux[] = {
 	SCIFB2_RXD_C_MARK, SCIFB2_TXD_C_MARK,
 };
+/* - TPU0 ------------------------------------------------------------------- */
+static const unsigned int tpu0_to0_pins[] = {
+	/* TO */
+	RCAR_GP_PIN(0, 20),
+};
+static const unsigned int tpu0_to0_mux[] = {
+	TPU0TO0_MARK,
+};
+static const unsigned int tpu0_to1_pins[] = {
+	/* TO */
+	RCAR_GP_PIN(0, 21),
+};
+static const unsigned int tpu0_to1_mux[] = {
+	TPU0TO1_MARK,
+};
+static const unsigned int tpu0_to2_pins[] = {
+	/* TO */
+	RCAR_GP_PIN(0, 22),
+};
+static const unsigned int tpu0_to2_mux[] = {
+	TPU0TO2_MARK,
+};
+static const unsigned int tpu0_to3_pins[] = {
+	/* TO */
+	RCAR_GP_PIN(0, 23),
+};
+static const unsigned int tpu0_to3_mux[] = {
+	TPU0TO3_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_link),
@@ -2416,6 +2445,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb2_clk_b),
 	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
 	SH_PFC_PIN_GROUP(scifb2_data_c),
+	SH_PFC_PIN_GROUP(tpu0_to0),
+	SH_PFC_PIN_GROUP(tpu0_to1),
+	SH_PFC_PIN_GROUP(tpu0_to2),
+	SH_PFC_PIN_GROUP(tpu0_to3),
 };
 
 static const char * const eth_groups[] = {
@@ -2520,6 +2553,13 @@ static const char * const scifb2_groups[] = {
 	"scifb2_data_c",
 };
 
+static const char * const tpu0_groups[] = {
+	"tpu0_to0",
+	"tpu0_to1",
+	"tpu0_to2",
+	"tpu0_to3",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(intc),
@@ -2531,6 +2571,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(tpu0),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.8.2.1
