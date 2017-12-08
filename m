From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  8 Dec 2017 12:32:50 +0100
Subject: [PATCH v9 6/6] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <20171208113250.359-1-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
Message-ID: <20171208113250.359-7-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

16 bits timers aren't accurate enough to be used as
clocksource, remove them from stm32f4 and stm32f7 devicetree.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32f429.dtsi | 32 --------------------------------
 arch/arm/boot/dts/stm32f746.dtsi | 32 --------------------------------
 2 files changed, 64 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 10099df8b73e..b507e04a52c6 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -107,14 +107,6 @@
 			};
 		};
 
-		timer3: timer at 40000400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000400 0x400>;
-			interrupts = <29>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM3)>;
-			status = "disabled";
-		};
-
 		timers3: timers at 40000400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -136,14 +128,6 @@
 			};
 		};
 
-		timer4: timer at 40000800 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000800 0x400>;
-			interrupts = <30>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM4)>;
-			status = "disabled";
-		};
-
 		timers4: timers at 40000800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -193,14 +177,6 @@
 			};
 		};
 
-		timer6: timer at 40001000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001000 0x400>;
-			interrupts = <54>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM6)>;
-			status = "disabled";
-		};
-
 		timers6: timers at 40001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -217,14 +193,6 @@
 			};
 		};
 
-		timer7: timer at 40001400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001400 0x400>;
-			interrupts = <55>;
-			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM7)>;
-			status = "disabled";
-		};
-
 		timers7: timers at 40001400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5f66d151eedb..bb3e262bd456 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -103,14 +103,6 @@
 			};
 		};
 
-		timer3: timer at 40000400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000400 0x400>;
-			interrupts = <29>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM3)>;
-			status = "disabled";
-		};
-
 		timers3: timers at 40000400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -132,14 +124,6 @@
 			};
 		};
 
-		timer4: timer at 40000800 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000800 0x400>;
-			interrupts = <30>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM4)>;
-			status = "disabled";
-		};
-
 		timers4: timers at 40000800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -189,14 +173,6 @@
 			};
 		};
 
-		timer6: timer at 40001000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001000 0x400>;
-			interrupts = <54>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM6)>;
-			status = "disabled";
-		};
-
 		timers6: timers at 40001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -213,14 +189,6 @@
 			};
 		};
 
-		timer7: timer at 40001400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001400 0x400>;
-			interrupts = <55>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM7)>;
-			status = "disabled";
-		};
-
 		timers7: timers at 40001400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.15.0
