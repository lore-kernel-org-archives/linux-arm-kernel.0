From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  9 Jun 2017 11:49:14 +0200
Subject: [PATCH v4 5/7] ARM: dts: meson6: switch to new bindings for UART nodes
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497001756-942-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the stable UART bindings by adding a XTAL node and using the
proper compatible strings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson6.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index b0fc91f..a334fbe 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,9 +70,37 @@
 		};
 	};
 
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
 	clk81: clk at 0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <200000000>;
 	};
 }; /* end of / */
+
+
+&uart_AO {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_A {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clk81>, <&clk81>;
+	clock-names = "xtal", "pclk", "baud";
+};
-- 
1.9.1
