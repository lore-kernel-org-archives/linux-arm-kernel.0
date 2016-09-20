From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 20 Sep 2016 11:36:42 +0800
Subject: [PATCH v7 3/8] binding-doc: usb: usb-device: add optional properties
 for power sequence
In-Reply-To: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1474342607-27512-4-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional properties for power sequence.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..3661dd2 100644
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
@@ -21,8 +25,12 @@ Example:
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	hub: genesys at 1 {
+	genesys: hub at 1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+
+		clocks = <&clks IMX6SX_CLK_CKO>;
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
+		reset-duration-us = <10>;
 	};
 }
-- 
2.7.4
