From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:21 +0200
Subject: [PATCH v2 6/9] ARM: dts: Add pinctrl node to STM32F429
In-Reply-To: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102604-11502-7-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STM32F429 MCU has 11 GPIO banks, with 16 pins per bank.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d78a481..9e6e75c 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include "armv7-m.dtsi"
+#include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 
 / {
 	clocks {
@@ -168,6 +169,102 @@
 			status = "disabled";
 		};
 
+		pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32f429-pinctrl";
+			ranges = <0 0x40020000 0x3000>;
+			pins-are-numbered;
+
+			gpioa: gpio at 40020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc 0 256>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc 0 257>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc 0 258>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc 0 259>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc 0 260>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc 0 261>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc 0 262>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc 0 263>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc 0 264>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc 0 265>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc 0 266>;
+				st,bank-name = "GPIOK";
+			};
+		};
+
 		rcc: rcc at 40023810 {
 			#clock-cells = <2>;
 			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
-- 
1.9.1
