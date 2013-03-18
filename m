From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:00 +0900
Subject: [PATCH 064/142] sh-pfc: sh73a0: Add USB pin groups and functions
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-65-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 76674af..61c682a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2909,6 +2909,14 @@ static const unsigned int sdhi2_ctrl_pins[] = {
 static const unsigned int sdhi2_ctrl_mux[] = {
 	SDHICMD2_MARK, SDHICLK2_MARK,
 };
+/* - USB -------------------------------------------------------------------- */
+static const unsigned int usb_vbus_pins[] = {
+	/* VBUS */
+	0,
+};
+static const unsigned int usb_vbus_mux[] = {
+	VBUS_0_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(bsc_data_0_7),
@@ -3050,6 +3058,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_data1),
 	SH_PFC_PIN_GROUP(sdhi2_data4),
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
+	SH_PFC_PIN_GROUP(usb_vbus),
 };
 
 static const char * const bsc_groups[] = {
@@ -3259,6 +3268,10 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_ctrl",
 };
 
+static const char * const usb_groups[] = {
+	"usb_vbus",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(bsc),
 	SH_PFC_FUNCTION(fsia),
@@ -3283,6 +3296,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(usb),
 };
 
 #define PINMUX_FN_BASE	GPIO_FN_VBUS_0
-- 
1.7.10.4
