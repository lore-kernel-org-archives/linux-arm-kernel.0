From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 6 Nov 2017 18:03:39 +0100
Subject: [PATCH v3 9/9] ARM: dts: stm32: add support of exti on stm32h743
 pinctrl
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509987819-29599-10-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of external interrupt (exti) on
all gpio ports of stm32h743.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 76bbd65..df0b441 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -49,6 +49,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32h743-pinctrl";
 			ranges = <0 0x58020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
 			pins-are-numbered;
 
 			gpioa: gpio at 58020000 {
@@ -57,6 +59,8 @@
 				reg = <0x0 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOA";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpiob: gpio at 58020400 {
@@ -65,6 +69,8 @@
 				reg = <0x400 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOB";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpioc: gpio at 58020800 {
@@ -73,6 +79,8 @@
 				reg = <0x800 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOC";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpiod: gpio at 58020c00 {
@@ -81,6 +89,8 @@
 				reg = <0xc00 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOD";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpioe: gpio at 58021000 {
@@ -89,6 +99,8 @@
 				reg = <0x1000 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOE";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpiof: gpio at 58021400 {
@@ -97,6 +109,8 @@
 				reg = <0x1400 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOF";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpiog: gpio at 58021800 {
@@ -105,6 +119,8 @@
 				reg = <0x1800 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOG";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpioh: gpio at 58021c00 {
@@ -113,6 +129,8 @@
 				reg = <0x1c00 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOH";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpioi: gpio at 58022000 {
@@ -121,6 +139,8 @@
 				reg = <0x2000 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOI";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpioj: gpio at 58022400 {
@@ -129,6 +149,8 @@
 				reg = <0x2400 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOJ";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			gpiok: gpio at 58022800 {
@@ -137,6 +159,8 @@
 				reg = <0x2800 0x400>;
 				clocks = <&timer_clk>;
 				st,bank-name = "GPIOK";
+				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			usart1_pins: usart1 at 0 {
-- 
2.7.4
