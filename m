From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Fri, 17 Mar 2017 10:58:57 +0100
Subject: [PATCH 4/5] ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
In-Reply-To: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1489744738-21632-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 support for STM32F746 SoC.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index f321ffe..89d3897 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -287,6 +287,29 @@
 					bias-disable;
 				};
 			};
+
+			i2c1_pins_b: i2c1 at 0 {
+				pins {
+					pinmux = <STM32F746_PB9_FUNC_I2C1_SDA>,
+						 <STM32F746_PB6_FUNC_I2C1_SCL>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <3>;
+				};
+			};
+		};
+
+		i2c1: i2c at 40005400 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc 149>;
+			clocks = <&rcc 0 405>;
+			st,i2c-timing = <0x40202537>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		rcc: rcc at 40023800 {
-- 
1.9.1
