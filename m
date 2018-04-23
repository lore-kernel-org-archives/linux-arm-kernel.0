From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Mon, 23 Apr 2018 11:48:29 +0200
Subject: [PATCH v2 3/5] ARM: dts: stm32: Add I2Cs pin control on STM32MP157C
In-Reply-To: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524476911-19056-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a dedicated pin control applied on I2C1,2,4 & 5

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..862e626 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -146,6 +146,36 @@
 				gpio-ranges = <&pinctrl 0 160 8>;
 			};
 
+			i2c1_pins_a: i2c1 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
+						 <STM32_PINMUX('F', 15, AF5)>; /* I2C1_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 4, AF4)>, /* I2C2_SCL */
+						 <STM32_PINMUX('H', 5, AF4)>; /* I2C2_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			i2c5_pins_a: i2c5 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 11, AF4)>, /* I2C5_SCL */
+						 <STM32_PINMUX('A', 12, AF4)>; /* I2C5_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
 			uart4_pins_a: uart4 at 0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
@@ -180,6 +210,16 @@
 				ngpios = <8>;
 				gpio-ranges = <&pinctrl_z 0 400 8>;
 			};
+
+			i2c4_pins_a: i2c4 at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('Z', 4, AF6)>, /* I2C4_SCL */
+						 <STM32_PINMUX('Z', 5, AF6)>; /* I2C4_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
 		};
 	};
 };
-- 
2.7.4
