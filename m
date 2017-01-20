From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 20 Jan 2017 10:15:08 +0100
Subject: [PATCH v9 7/8] ARM: dts: stm32: add Timers driver for stm32f429 MCU
In-Reply-To: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1484903709-11650-8-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Timers and it sub-nodes into DT for stm32f429 family.

version 9:
- re-order timers node per addresses

version 6:
- split patch in two: one for SoC family and one for stm32f469
  discovery board.

version 5:
- rename gptimer node to timers
- re-order timers node per addresses

version 4:
- remove unwanted indexing in pwm@ and timer@ node name
- use "reg" instead of additional parameters to set timer
  configuration

version 3:
- use "st,stm32-timer-trigger" in DT

version 2:
- use parameters to describe hardware capabilities
- do not use references for pwm and iio timer subnodes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 275 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..b608935 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -79,6 +79,27 @@
 			status = "disabled";
 		};
 
+		timers2: timers at 40000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc 0 128>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 1 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+		};
+
 		timer3: timer at 40000400 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000400 0x400>;
@@ -87,6 +108,27 @@
 			status = "disabled";
 		};
 
+		timers3: timers at 40000400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000400 0x400>;
+			clocks = <&rcc 0 129>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 2 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
 		timer4: timer at 40000800 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000800 0x400>;
@@ -95,6 +137,27 @@
 			status = "disabled";
 		};
 
+		timers4: timers at 40000800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000800 0x400>;
+			clocks = <&rcc 0 130>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 3 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
 		timer5: timer at 40000c00 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
@@ -102,6 +165,27 @@
 			clocks = <&rcc 0 131>;
 		};
 
+		timers5: timers at 40000c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000C00 0x400>;
+			clocks = <&rcc 0 131>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 4 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <4>;
+				status = "disabled";
+			};
+		};
+
 		timer6: timer at 40001000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40001000 0x400>;
@@ -110,6 +194,22 @@
 			status = "disabled";
 		};
 
+		timers6: timers at 40001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc 0 132>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer at 5 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <5>;
+				status = "disabled";
+			};
+		};
+
 		timer7: timer at 40001400 {
 			compatible = "st,stm32-timer";
 			reg = <0x40001400 0x400>;
@@ -118,6 +218,73 @@
 			status = "disabled";
 		};
 
+		timers7: timers at 40001400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001400 0x400>;
+			clocks = <&rcc 0 133>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer at 6 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <6>;
+				status = "disabled";
+			};
+		};
+
+			timers12: timers at 40001800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001800 0x400>;
+			clocks = <&rcc 0 134>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 11 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <11>;
+				status = "disabled";
+			};
+		};
+
+		timers13: timers at 40001c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001C00 0x400>;
+			clocks = <&rcc 0 135>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers14: timers at 40002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc 0 136>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
 		usart2: serial at 40004400 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
@@ -169,6 +336,48 @@
 			status = "disabled";
 		};
 
+		timers1: timers at 40010000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40010000 0x400>;
+			clocks = <&rcc 0 160>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+		};
+
+		timers8: timers at 40010400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40010400 0x400>;
+			clocks = <&rcc 0 161>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 7 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <7>;
+				status = "disabled";
+			};
+		};
+
 		usart1: serial at 40011000 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011000 0x400>;
@@ -201,6 +410,57 @@
 			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
 		};
 
+		timers9: timers at 40014000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014000 0x400>;
+			clocks = <&rcc 0 176>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer at 8 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <8>;
+				status = "disabled";
+			};
+		};
+
+		timers10: timers at 40014400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014400 0x400>;
+			clocks = <&rcc 0 177>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers11: timers at 40014800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014800 0x400>;
+			clocks = <&rcc 0 178>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
 		pwrcfg: power-config at 40007000 {
 			compatible = "syscon";
 			reg = <0x40007000 0x400>;
@@ -355,6 +615,21 @@
 					slew-rate = <2>;
 				};
 			};
+
+			pwm1_pins: pwm at 1 {
+				pins {
+					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
+						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
+						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
+				};
+			};
+
+			pwm3_pins: pwm at 3 {
+				pins {
+					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
+						 <STM32F429_PB5_FUNC_TIM3_CH2>;
+				};
+			};
 		};
 
 		rcc: rcc at 40023810 {
-- 
1.9.1
