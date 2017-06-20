From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 20 Jun 2017 13:41:29 +0200
Subject: [PATCH v2 4/5] ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
In-Reply-To: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1497958890-5530-5-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 support for STM32F746 SoC.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
Changes in V2:
  * Update I2C SoC device tree with latest Linux version
---
 arch/arm/boot/dts/stm32f746.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index c2765ce..b00b96b 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -326,6 +326,16 @@
 					bias-disable;
 				};
 			};
+
+			i2c1_pins_b: i2c1 at 0 {
+				pins {
+					pinmux = <STM32F746_PB9_FUNC_I2C1_SDA>,
+						 <STM32F746_PB8_FUNC_I2C1_SCL>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
 		};
 
 		crc: crc at 40023000 {
@@ -344,6 +354,18 @@
 			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
 			assigned-clock-rates = <1000000>;
 		};
+
+		i2c1: i2c at 40005400 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C1)>;
+			clocks = <&rcc 1 CLK_I2C1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
