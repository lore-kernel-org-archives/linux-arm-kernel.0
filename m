From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 22 Dec 2016 14:35:02 +0100
Subject: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
In-Reply-To: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 support for STM32F429 SoC

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 7de52ee..2277a2d 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,6 +48,7 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -140,6 +141,18 @@
 			status = "disabled";
 		};
 
+		i2c1: i2c at 40005400 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc STM32F4_APB1_RESET(I2C1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C1)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usart7: serial at 40007800 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
@@ -337,6 +350,16 @@
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
 
 		rcc: rcc at 40023810 {
-- 
1.9.1
