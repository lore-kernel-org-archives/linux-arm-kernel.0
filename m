From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Aug 2015 15:15:41 +0800
Subject: [PATCH v3 04/10] Doc: usb: ci-hdrc-usb2: add ahb-burst-config for
 binding doc
In-Reply-To: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
References: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438931747-25209-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to change ahb burst configuration for platforms, it is
vendor specific.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 4159c8c..d52a747 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -32,6 +32,11 @@ Optional properties:
 - external-vbus-divider: (FSL only) enables off-chip resistor divider for Vbus
 - itc-setting: interrupt threshold control register control, the setting
   should be aligned with ITC bits at register USBCMD.
+- ahb-burst-config: it is vendor dependent, the required value should be
+  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This
+  property is used to change AHB burst configuration, check the chipidea
+  spec for meaning of each value. If this property is not existed, it
+  will use the reset value.
 
 Example:
 
@@ -44,4 +49,6 @@ Example:
 		phy-names = "usb-phy";
 		vbus-supply = <&reg_usb0_vbus>;
 		gadget-itc-setting = <0x4>; /* 4 micro-frames */
+		 /* Incremental burst of unspecified length */
+		ahb-burst-config = <0x0>;
 	};
-- 
1.9.1
