From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  9 Jun 2017 11:49:16 +0200
Subject: [PATCH v4 7/7] ARM: dts: meson8b: switch to new bindings for UART
 nodes
In-Reply-To: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497001756-942-8-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the stable UART bindings by adding a XTAL node and using the
proper compatible strings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index d9f116a..651ad4a 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -82,6 +82,13 @@
 			reg = <0x203>;
 		};
 	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
 }; /* end of / */
 
 &aobus {
@@ -178,17 +185,25 @@
 };
 
 &uart_AO {
-	clocks = <&clkc CLKID_CLK81>;
+	compatible = "amlogic,meson8b-uart", "amlogic,meson-ao-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_A {
-	clocks = <&clkc CLKID_CLK81>;
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_B {
-	clocks = <&clkc CLKID_CLK81>;
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
-	clocks = <&clkc CLKID_CLK81>;
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
-- 
1.9.1
