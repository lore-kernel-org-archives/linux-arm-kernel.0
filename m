From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Oct 2017 09:43:34 +0200
Subject: [PATCH v5 4/4] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1508312614-27750-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1508312614-27750-5-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16 bits timers aren't accurate enough to be used as
clocksource, remove them from stm32f4 and stm32f7 devicetree.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32f429.dtsi | 32 --------------------------------
 arch/arm/boot/dts/stm32f746.dtsi | 32 --------------------------------
 2 files changed, 64 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index dd7e99b..ac9a3e6 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -108,14 +108,6 @@
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
@@ -137,14 +129,6 @@
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
@@ -194,14 +178,6 @@
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
@@ -218,14 +194,6 @@
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
index 5633860..a9077e6 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -82,22 +82,6 @@
 			status = "disabled";
 		};
 
-		timer3: timer at 40000400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000400 0x400>;
-			interrupts = <29>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM3)>;
-			status = "disabled";
-		};
-
-		timer4: timer at 40000800 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000800 0x400>;
-			interrupts = <30>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM4)>;
-			status = "disabled";
-		};
-
 		timer5: timer at 40000c00 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
@@ -105,22 +89,6 @@
 			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
 		};
 
-		timer6: timer at 40001000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001000 0x400>;
-			interrupts = <54>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM6)>;
-			status = "disabled";
-		};
-
-		timer7: timer at 40001400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001400 0x400>;
-			interrupts = <55>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM7)>;
-			status = "disabled";
-		};
-
 		rtc: rtc at 40002800 {
 			compatible = "st,stm32-rtc";
 			reg = <0x40002800 0x400>;
-- 
2.7.4
