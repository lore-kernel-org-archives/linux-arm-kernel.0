From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:01 +0900
Subject: [PATCH 065/142] sh-pfc: sh73a0: Add IrDA pin groups and functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-66-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 61c682a..8fc5eb0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2169,6 +2169,21 @@ static const unsigned int i2c3_2_pins[] = {
 static const unsigned int i2c3_2_mux[] = {
 	PORT115_I2C_SCL3_MARK, PORT116_I2C_SDA3_MARK,
 };
+/* - IrDA ------------------------------------------------------------------- */
+static const unsigned int irda_0_pins[] = {
+	/* OUT, IN, FIRSEL */
+	241, 242, 243,
+};
+static const unsigned int irda_0_mux[] = {
+	PORT241_IRDA_OUT_MARK, PORT242_IRDA_IN_MARK, PORT243_IRDA_FIRSEL_MARK,
+};
+static const unsigned int irda_1_pins[] = {
+	/* OUT, IN, FIRSEL */
+	49, 53, 54,
+};
+static const unsigned int irda_1_mux[] = {
+	PORT49_IRDA_OUT_MARK, PORT53_IRDA_IN_MARK, PORT54_IRDA_FIRSEL_MARK,
+};
 /* - KEYSC ------------------------------------------------------------------ */
 static const unsigned int keysc_in5_pins[] = {
 	/* KEYIN[0:4] */
@@ -2963,6 +2978,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c3_0),
 	SH_PFC_PIN_GROUP(i2c3_1),
 	SH_PFC_PIN_GROUP(i2c3_2),
+	SH_PFC_PIN_GROUP(irda_0),
+	SH_PFC_PIN_GROUP(irda_1),
 	SH_PFC_PIN_GROUP(keysc_in5),
 	SH_PFC_PIN_GROUP(keysc_in6),
 	SH_PFC_PIN_GROUP(keysc_in7),
@@ -3125,6 +3142,11 @@ static const char * const i2c3_groups[] = {
 	"i2c3_2",
 };
 
+static const char * const irda_groups[] = {
+	"irda_0",
+	"irda_1",
+};
+
 static const char * const keysc_groups[] = {
 	"keysc_in5",
 	"keysc_in6",
@@ -3280,6 +3302,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(fsid),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(irda),
 	SH_PFC_FUNCTION(keysc),
 	SH_PFC_FUNCTION(lcd),
 	SH_PFC_FUNCTION(lcd2),
-- 
1.7.10.4
