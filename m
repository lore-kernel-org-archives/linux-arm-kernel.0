From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:25:21 +0800
Subject: [RESEND PATCH v3 1/5] doc: dt-binding: ci-hdrc-usb2: split vendor
 specific properties
In-Reply-To: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
References: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1443579925-1330-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each vendor may have its specific properties, they are not belonged
to common optional properties, split them from common's.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 77946f5..27dc705 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -27,10 +27,6 @@ Optional properties:
 - vbus-supply: reference to the VBUS regulator
 - maximum-speed: limit the maximum connection speed to "full-speed".
 - tpl-support: TPL (Targeted Peripheral List) feature for targeted hosts
-- fsl,usbmisc: (FSL only) phandler of non-core register device, with one
-  argument that indicate usb controller index
-- disable-over-current: (FSL only) disable over current detect
-- external-vbus-divider: (FSL only) enables off-chip resistor divider for Vbus
 - itc-setting: interrupt threshold control register control, the setting
   should be aligned with ITC bits at register USBCMD.
 - ahb-burst-config: it is vendor dependent, the required value should be
@@ -54,6 +50,12 @@ Optional properties:
 - phy-clkgate-delay-us: the delay time (us) between putting the PHY into
   low power mode and gating the PHY clock.
 
+i.mx specific properties
+- fsl,usbmisc: phandler of non-core register device, with one
+  argument that indicate usb controller index
+- disable-over-current: disable over current detect
+- external-vbus-divider: enables off-chip resistor divider for Vbus
+
 Example:
 
 	usb at f7ed0000 {
-- 
1.9.1
