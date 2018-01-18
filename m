From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 18 Jan 2018 15:34:24 +0100
Subject: [PATCH v3 08/14] ARM: dts: stm32: Add pin map for SDIO controller on
 stm32f4
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1516286070-24927-9-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Merello <andrea.merello@gmail.com>

This patch adds the pin configuration for SDIO controller on
stm32f4.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none


 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index ae94d86..3520289 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -338,6 +338,37 @@
 					slew-rate = <3>;
 				};
 			};
+
+			sdio_pins: sdio_pins at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDIO_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDIO_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDIO_CK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDIO_CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od: sdio_pins_od at 0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDIO_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDIO_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDIO_CK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDIO_CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
