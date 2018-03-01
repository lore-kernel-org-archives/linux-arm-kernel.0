From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 1 Mar 2018 11:53:38 +0100
Subject: [PATCH v2 1/6] ARM: dts: stm32: Add sdio pins definition for stm32f7
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1519901623-23216-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add sdio pins definition for the 2 sdio instances embeds in stm32f746.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a 

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index f518de184e52..9314128df185 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -222,6 +222,68 @@
 					slew-rate = <2>;
 				};
 			};
+
+			sdio_pins_a: sdio_pins_a at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1 CLK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od_a: sdio_pins_od_a at 0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1 CLK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_b: sdio_pins_b at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
+						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
+						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
+						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
+						 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC2 CLK */
+						 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od_b: sdio_pins_od_b at 0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
+						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
+						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
+						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
+						 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC2 CLK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
