From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 23 May 2018 17:47:54 +0200
Subject: [PATCH V4 3/8] ARM: dts: stm32: add ethernet pins to stm32mp157c
In-Reply-To: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
References: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1527090479-5263-4-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet pins on stm32mp157c.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..cf83eb244 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -158,6 +158,52 @@
 					bias-disable;
 				};
 			};
+
+			ethernet0_rgmii_pins_a: rgmii-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
+						 <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
+						 <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
+						 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RGMII_TXD1 */
+						 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
+						 <STM32_PINMUX('E', 2, AF11)>, /* ETH_RGMII_TXD3 */
+						 <STM32_PINMUX('B', 11, AF11)>, /* ETH_RGMII_TX_CTL */
+						 <STM32_PINMUX('A', 2, AF11)>, /* ETH_MDIO */
+						 <STM32_PINMUX('C', 1, AF11)>; /* ETH_MDC */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
+						 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
+						 <STM32_PINMUX('B', 0, AF11)>, /* ETH_RGMII_RXD2 */
+						 <STM32_PINMUX('B', 1, AF11)>, /* ETH_RGMII_RXD3 */
+						 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RGMII_RX_CLK */
+						 <STM32_PINMUX('A', 7, AF11)>; /* ETH_RGMII_RX_CTL */
+					bias-disable;
+				};
+			};
+
+			ethernet0_rgmii_pins_sleep_a: rgmii-sleep-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
+						 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+						 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
+						 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
+						 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
+						 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
+						 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
+						 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
+						 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_MDC */
+						 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
+						 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
+						 <STM32_PINMUX('B', 0, ANALOG)>, /* ETH_RGMII_RXD2 */
+						 <STM32_PINMUX('B', 1, ANALOG)>, /* ETH_RGMII_RXD3 */
+						 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RGMII_RX_CLK */
+						 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH_RGMII_RX_CTL */
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z {
-- 
1.9.1
