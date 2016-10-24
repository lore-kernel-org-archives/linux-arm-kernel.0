From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:34 +0200
Subject: [PATCH/RFT v2 17/17] ARM: dts: da850: add usb device node
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-18-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This adds the usb (ohci) device node for the da850 soc.
Also it enables it for the lcdk board

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..fa91339 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -86,6 +86,14 @@
 	};
 };
 
+&usb_phy {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
 &serial2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&serial2_rxtx_pins>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 33fcdce..ec2cec3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -381,6 +381,14 @@
 			#phy-cells = <1>;
 			status = "disabled";
 		};
+		usb: usb at 0225000 {
+			compatible = "ti,da830-ohci";
+			reg = <0x225000 0x1000>;
+			interrupts = <59>;
+			phys = <&usb_phy 1>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
1.9.1
