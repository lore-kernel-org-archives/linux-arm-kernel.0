From: erwan.leray@st.com (Erwan Le Ray)
Date: Tue, 15 May 2018 14:23:59 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: m_can activation on stm32mp157c-ev1
In-Reply-To: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
References: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
Message-ID: <1526387039-14813-3-git-send-email-erwan.leray@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add activation of the Controller Area Network m_can on stm32mp157c-ev1
board.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 88e9133..2e4c5e3 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -185,6 +185,19 @@
 				};
 			};
 
+			m_can1_pins_a: m_can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
+					slew-rate = <1>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('I', 9, AF9)>; /* CAN1_RX */
+					bias-disable;
+				};
+			};
+
 			pwm2_pins_a: pwm2-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 9382d80..3be73d2 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -42,6 +42,12 @@
 	status = "okay";
 };
 
+&m_can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&m_can1_pins_a>;
+	status = "okay";
+};
+
 &qspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a &qspi_bk2_pins_a>;
-- 
1.9.1
