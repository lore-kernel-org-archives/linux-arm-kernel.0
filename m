From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:09 +0900
Subject: [PATCH 073/142] sh-pfc: r8a7779: Add USB pin groups and functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-74-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 946572bc..6043d2c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2198,6 +2198,30 @@ static const unsigned int sdhi3_wp_pins[] = {
 static const unsigned int sdhi3_wp_mux[] = {
 	SD3_WP_MARK,
 };
+/* - USB0 ------------------------------------------------------------------- */
+static const unsigned int usb0_pins[] = {
+	/* OVC */
+	150, 154,
+};
+static const unsigned int usb0_mux[] = {
+	USB_OVC0_MARK, USB_PENC0_MARK,
+};
+/* - USB1 ------------------------------------------------------------------- */
+static const unsigned int usb1_pins[] = {
+	/* OVC */
+	152, 155,
+};
+static const unsigned int usb1_mux[] = {
+	USB_OVC1_MARK, USB_PENC1_MARK,
+};
+/* - USB2 ------------------------------------------------------------------- */
+static const unsigned int usb2_pins[] = {
+	/* OVC, PENC */
+	125, 156,
+};
+static const unsigned int usb2_mux[] = {
+	USB_OVC2_MARK, USB_PENC2_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_rgb666),
@@ -2301,6 +2325,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi3_ctrl),
 	SH_PFC_PIN_GROUP(sdhi3_cd),
 	SH_PFC_PIN_GROUP(sdhi3_wp),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
+	SH_PFC_PIN_GROUP(usb2),
 };
 
 static const char * const du0_groups[] = {
@@ -2455,6 +2482,18 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_wp",
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
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
@@ -2473,6 +2512,9 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(usb2),
 };
 
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
1.7.10.4
