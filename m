From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 15 Nov 2018 08:52:29 +0000
Subject: [PATCH 2/3] ARM: dts: stm32: add can1 sleep pins muxing
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Message-ID: <1542271942-28130-3-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add can1 pinctrl definition for low-power mode

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index c485127..9ec4694 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -246,6 +246,13 @@
 				};
 			};
 
+			m_can1_sleep_pins_a: m_can1-sleep at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* CAN1_TX */
+						 <STM32_PINMUX('I', 9, ANALOG)>; /* CAN1_RX */
+				};
+			};
+
 			pwm2_pins_a: pwm2-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
-- 
1.9.1
