From: hao5781286@gmail.com (hao_zhang)
Date: Wed, 13 Dec 2017 22:46:28 +0800
Subject: [PATCH v4 3/4] ARM: dts: add pwm node for r40.
Message-ID: <20171213144628.GA18246@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pwm node for r40.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |  6 ++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 8c5efe2..6cf6273 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -196,6 +196,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 173dcc1..6628b17 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -295,6 +295,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pins: pwm0-pin {
+				pins = "PB2", "PB3";
+				function = "pwm";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -306,6 +311,14 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm at 1c23400 {
+			     compatible = "allwinner,sun8i-r40-pwm";
+			     reg = <0x01c23400 0x154>;
+			     clocks = <&osc24M>;
+			     #pwm-cells = <3>;
+			     status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4
