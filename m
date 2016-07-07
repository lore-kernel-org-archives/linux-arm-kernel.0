From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 7 Jul 2016 17:14:49 +0800
Subject: [PATCH 3/6] binding-doc: usb: usb-device: add optional properties for
 power sequence
In-Reply-To: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1467882892-27589-4-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional properties for power sequence.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..ef0c9b2 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -13,6 +13,10 @@ Required properties:
 - reg: the port number which this device is connecting to, the range
   is 1-31.
 
+Optional properties:
+power sequence properties, see
+Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt for detail
+
 Example:
 
 &usb1 {
@@ -24,5 +28,11 @@ Example:
 	hub: genesys at 1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+
+		power-sequence;
+		clocks = <&clks IMX6SX_CLK_CKO>;
+		clock-names = "pwrseq-clk";
+		pwrseq-reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
+		pwrseq-reset-duration-us = <10>;
 	};
 }
-- 
1.9.1
