From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Jul 2014 14:29:35 +0200
Subject: [PATCH v2 2/2] usb: ci_hdrc_imx doc: fsl,usbphy is required
In-Reply-To: <1405081775-21508-1-git-send-email-mpa@pengutronix.de>
References: <1405081775-21508-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1405081775-21508-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl,usbphy is no optional property. This patch moves it to the list of
required properties.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
index a6a32cb7f777..1bae71e9ad47 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be "fsl,imx27-usb"
 - reg: Should contain registers location and length
 - interrupts: Should contain controller interrupt
+- fsl,usbphy: phandle of usb phy that connects to the port
 
 Recommended properies:
 - phy_type: the type of the phy connected to the core. Should be one
@@ -12,7 +13,6 @@ Recommended properies:
 - dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
 
 Optional properties:
-- fsl,usbphy: phandler of usb phy that connects to the only one port
 - fsl,usbmisc: phandler of non-core register device, with one argument
   that indicate usb controller index
 - vbus-supply: regulator for vbus
-- 
2.0.0
