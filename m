From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 12 May 2017 15:56:44 +0800
Subject: [PATCH v3 7/9] arm: dts: mt7623: enable the usb device on the mt7623n
 rfb
In-Reply-To: <cover.1494574682.git.sean.wang@mediatek.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
Message-ID: <98cb8c175852364c58425d7b59fe7b182e2b8d02.1494574682.git.sean.wang@mediatek.com>
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
