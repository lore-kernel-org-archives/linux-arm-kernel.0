From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 17 Apr 2018 15:45:28 +0200
Subject: [PATCH 2/4] ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1
 board
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1523972730-29240-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32mp157c evaluation board has following PWM pins available on GPIO
expansion connector:
- TIM2_CH4 (PA3)
- TIM8_CH4 (PI2)
- TIM12_CH1 (PH6)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..867cfeb 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -158,6 +158,33 @@
 					bias-disable;
 				};
 			};
+
+			pwm2_pins_a: pwm2 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm8_pins_a: pwm8 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm12_pins_a: pwm12 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z {
-- 
1.9.1
