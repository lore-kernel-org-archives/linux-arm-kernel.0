From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 22 Nov 2016 17:13:27 +0100
Subject: [PATCH 7/7] add stm32 multi-functions timer driver in DT
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1479831207-32699-8-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add timers MFD and childs into DT for stm32f4.
Define and enable pwm1 and pwm3 for stm32f469 discovery board

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      | 246 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts |  29 ++++
 2 files changed, 275 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index bca491d..28a0fe9 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -355,6 +355,21 @@
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
@@ -426,6 +441,237 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		mfd_timer1: mfdtimer1 at 40010000 {
+			compatible = "st,stm32-mfd-timer1";
+			reg = <0x40010000 0x400>;
+			clocks = <&rcc 0 160>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <27>;
+			status = "disabled";
+
+			pwm1: pwm1 at 40010000 {
+				compatible = "st,stm32-pwm1";
+				status = "disabled";
+			};
+
+			iiotimer1: iiotimer1 at 40010000 {
+				compatible = "st,stm32-iio-timer1";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer2: mfdtimer2 at 40000000 {
+			compatible = "st,stm32-mfd-timer2";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc 0 128>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <28>;
+			status = "disabled";
+
+			pwm2: pwm2 at 40000000 {
+				compatible = "st,stm32-pwm2";
+				status = "disabled";
+			};
+			iiotimer2: iiotimer2 at 40000000 {
+				compatible = "st,stm32-iio-timer2";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer3: mfdtimer3 at 40000400 {
+			compatible = "st,stm32-mfd-timer3";
+			reg = <0x40000400 0x400>;
+			clocks = <&rcc 0 129>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <29>;
+			status = "disabled";
+
+			pwm3: pwm3 at 40000400 {
+				compatible = "st,stm32-pwm3";
+				status = "disabled";
+			};
+			iiotimer3: iiotimer3 at 40000400 {
+				compatible = "st,stm32-iio-timer3";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer4: mfdtimer4 at 40000800 {
+			compatible = "st,stm32-mfd-timer4";
+			reg = <0x40000800 0x400>;
+			clocks = <&rcc 0 130>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <30>;
+			status = "disabled";
+
+			pwm4: pwm4 at 40000800 {
+				compatible = "st,stm32-pwm4";
+				status = "disabled";
+			};
+			iiotimer4: iiotimer4 at 40000800 {
+				compatible = "st,stm32-iio-timer4";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer5: mfdtimer5 at 40000C00 {
+			compatible = "st,stm32-mfd-timer5";
+			reg = <0x40000C00 0x400>;
+			clocks = <&rcc 0 131>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <50>;
+			status = "disabled";
+
+			pwm5: pwm5 at 40000C00 {
+				compatible = "st,stm32-pwm5";
+				status = "disabled";
+			};
+			iiotimer5: iiotimer5 at 40000800 {
+				compatible = "st,stm32-iio-timer5";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer6: mfdtimer6 at 40001000 {
+			compatible = "st,stm32-mfd-timer6";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc 0 132>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <54>;
+			status = "disabled";
+
+			iiotimer6: iiotimer6 at 40001000 {
+				compatible = "st,stm32-iio-timer6";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer7: mfdtimer7 at 40001400 {
+			compatible = "st,stm32-mfd-timer7";
+			reg = <0x40001400 0x400>;
+			clocks = <&rcc 0 133>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <55>;
+			status = "disabled";
+
+			iiotimer7: iiotimer7 at 40001400 {
+				compatible = "st,stm32-iio-timer7";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer8: mfdtimer8 at 40010400 {
+			compatible = "st,stm32-mfd-timer8";
+			reg = <0x40010400 0x400>;
+			clocks = <&rcc 0 161>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <46>;
+			status = "disabled";
+
+			pwm8: pwm8 at 40010400 {
+				compatible = "st,stm32-pwm8";
+				status = "disabled";
+			};
+
+			iiotimer8: iiotimer7 at 40010400 {
+				compatible = "st,stm32-iio-timer8";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer9: mfdtimer9 at 40014000 {
+			compatible = "st,stm32-mfd-timer9";
+			reg = <0x40014000 0x400>;
+			clocks = <&rcc 0 176>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <24>;
+			status = "disabled";
+
+			pwm9: pwm9 at 40014000 {
+				compatible = "st,stm32-pwm9";
+				status = "disabled";
+			};
+
+			iiotimer9: iiotimer9 at 40014000 {
+				compatible = "st,stm32-iio-timer9";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer10: mfdtimer10 at 40014400 {
+			compatible = "st,stm32-mfd-timer10";
+			reg = <0x40014400 0x400>;
+			clocks = <&rcc 0 177>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <25>;
+			status = "disabled";
+
+			pwm10: pwm10 at 40014400 {
+				compatible = "st,stm32-pwm10";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer11: mfdtimer11 at 40014800 {
+			compatible = "st,stm32-mfd-timer11";
+			reg = <0x40014800 0x400>;
+			clocks = <&rcc 0 178>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <26>;
+			status = "disabled";
+
+			pwm11: pwm11 at 40014800 {
+				compatible = "st,stm32-pwm11";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer12: mfdtimer12 at 40001800 {
+			compatible = "st,stm32-mfd-timer12";
+			reg = <0x40001800 0x400>;
+			clocks = <&rcc 0 134>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <43>;
+			status = "disabled";
+
+			pwm12: pwm12 at 40001800 {
+				compatible = "st,stm32-pwm12";
+				status = "disabled";
+			};
+			iiotimer12: iiotimer12 at 40001800 {
+				compatible = "st,stm32-iio-timer12";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer13: mfdtimer13 at 40001C00 {
+			compatible = "st,stm32-mfd-timer13";
+			reg = <0x40001C00 0x400>;
+			clocks = <&rcc 0 135>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <44>;
+			status = "disabled";
+
+			pwm13: pwm13 at 40001C00 {
+				compatible = "st,stm32-pwm13";
+				status = "disabled";
+			};
+		};
+
+		mfd_timer14: mfdtimer14 at 40002000 {
+			compatible = "st,stm32-mfd-timer14";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc 0 136>;
+			clock-names = "mfd_timer_clk";
+			interrupts = <45>;
+			status = "disabled";
+
+			pwm14: pwm14 at 40002000 {
+				compatible = "st,stm32-pwm14";
+				status = "disabled";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..a8f1788 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -81,3 +81,32 @@
 &usart3 {
 	status = "okay";
 };
+
+&mfd_timer1 {
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-0	= <&pwm1_pins>;
+	pinctrl-names	= "default";
+	st,breakinput-polarity = <0>;
+	status = "okay";
+};
+
+&iiotimer1 {
+	status = "okay";
+};
+
+&mfd_timer3 {
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-0	= <&pwm3_pins>;
+	pinctrl-names	= "default";
+	status = "okay";
+};
+
+&iiotimer3 {
+	status = "okay";
+};
-- 
1.9.1
