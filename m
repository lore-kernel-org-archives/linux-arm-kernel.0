From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 12:02:45 +0800
Subject: [PATCH v4 7/9] arm: dts: mt7623: enable the usb device on the mt7623n
 rfb
In-Reply-To: <cover.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
Message-ID: <4cb528c77f4d44bd0932b69f39b0d5b557d9eab1.1495683769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

All versions of the mt7623n RFB have an USB port so enable the device.
There is a gpio that gets used to power up the port supply. Add support
for this gpio using the fixed-regulator driver.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-rfb.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 4963e6a..2964b4c 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -28,6 +28,15 @@
 		serial1 = &uart1;
 		serial2 = &uart2;
 	};
+
+	usb_p1_vbus: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &uart0 {
@@ -41,3 +50,12 @@
 &uart2 {
 	status = "okay";
 };
+
+&usb1 {
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
-- 
2.7.4
