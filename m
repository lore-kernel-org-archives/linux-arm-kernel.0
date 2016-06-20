From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 20 Jun 2016 18:20:07 +0200
Subject: [PATCH v3 3/5] ARM: dts: Add I2C1 support for STM32F429 SoC
In-Reply-To: <1466439609-1814-1-git-send-email-cedric.madianga@gmail.com>
References: <1466439609-1814-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1466439609-1814-4-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 434d4b9..4eaa107 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -323,6 +323,16 @@
 					slew-rate = <2>;
 				};
 			};
+
+			i2c1_pins_b: i2c1 at 0 {
+				pins1 {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
+					drive-open-drain;
+				};
+				pins2 {
+					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
+				};
+			};
 		};
 
 		rcc: rcc at 40023800 {
@@ -395,6 +405,18 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		i2c1: i2c at 40005400 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc 277>;
+			clocks = <&rcc 0 149>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
