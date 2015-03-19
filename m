From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:12 +0800
Subject: [PATCH 01/12] Doc: usb: ci-hdrc-imx: add gadget-itc-setting for
 binding doc
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to configure the ITC (in register USBCMD) value
for gadget mode.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
index 38a5480..c21171e 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
@@ -20,6 +20,8 @@ Optional properties:
 - external-vbus-divider: enables off-chip resistor divider for Vbus
 - maximum-speed: limit the maximum connection speed to "full-speed".
 - tpl-support: TPL (Targeted Peripheral List) feature for targeted hosts
+- gadget-itc-setting: the ITC setting for gadget, the required value
+  should be aligned with ITC bits at register USBCMD.
 
 Examples:
 usb at 02184000 { /* USB OTG */
@@ -32,4 +34,5 @@ usb at 02184000 { /* USB OTG */
 	external-vbus-divider;
 	maximum-speed = "full-speed";
 	tpl-support;
+	gadget-itc-setting = <0x4>; /* 4 micro-frames */
 };
-- 
1.9.1
