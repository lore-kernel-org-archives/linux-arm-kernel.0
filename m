From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:15:19 +0200
Subject: [PATCH 13/14] sh-pfc: r8a7790: Add USB pin groups and functions
In-Reply-To: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671720-8794-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 2fd904f..fa501ef 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2869,6 +2869,30 @@ static const unsigned int tpu0_to3_pins[] = {
 static const unsigned int tpu0_to3_mux[] = {
 	TPU0TO3_MARK,
 };
+/* - USB0 ------------------------------------------------------------------- */
+static const unsigned int usb0_pins[] = {
+	/* PWEN, OVC/VBUS */
+	RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
+};
+static const unsigned int usb0_mux[] = {
+	USB0_PWEN_MARK, USB0_OVC_VBUS_MARK,
+};
+/* - USB1 ------------------------------------------------------------------- */
+static const unsigned int usb1_pins[] = {
+	/* PWEN, OVC */
+	RCAR_GP_PIN(5, 20), RCAR_GP_PIN(5, 21),
+};
+static const unsigned int usb1_mux[] = {
+	USB1_PWEN_MARK, USB1_OVC_MARK,
+};
+/* - USB2 ------------------------------------------------------------------- */
+static const unsigned int usb2_pins[] = {
+	/* PWEN, OVC */
+	RCAR_GP_PIN(5, 22), RCAR_GP_PIN(5, 23),
+};
+static const unsigned int usb2_mux[] = {
+	USB2_PWEN_MARK, USB2_OVC_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(eth_link),
@@ -3021,6 +3045,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(tpu0_to1),
 	SH_PFC_PIN_GROUP(tpu0_to2),
 	SH_PFC_PIN_GROUP(tpu0_to3),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(usb2),
 };
 
 static const char * const eth_groups[] = {
@@ -3245,6 +3272,18 @@ static const char * const tpu0_groups[] = {
 	"tpu0_to3",
 };
 
+static const char * const usb0_groups[] = {
+	"usb0",
+};
+
+static const char * const usb1_groups[] = {
+	"usb1",
+};
+
+static const char * const usb2_groups[] = {
+	"usb2",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
@@ -3270,6 +3309,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(sdhi3),
 	SH_PFC_FUNCTION(tpu0),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(usb2),
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
1.8.1.5
