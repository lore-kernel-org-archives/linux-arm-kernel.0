From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:22 +0200
Subject: [PATCH v2 7/9] ARM: dts: Add USART1 pin config to STM32F429 boards
In-Reply-To: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102604-11502-8-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch selects USART1 pin configuration on PA9/PA10 pins
for both Eval and Disco boards.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts  |  2 ++
 arch/arm/boot/dts/stm32f429-disco.dts |  2 ++
 arch/arm/boot/dts/stm32f429.dtsi      | 13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6964fc9..71fe17a 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -71,5 +71,7 @@
 };
 
 &usart1 {
+	pinctrl-0 = <&usart1_pins_a>;
+	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index f0b731d..e3ce796 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -71,5 +71,7 @@
 };
 
 &usart1 {
+	pinctrl-0 = <&usart1_pins_a>;
+	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 9e6e75c..eb3580e 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -263,6 +263,19 @@
 				clocks = <&rcc 0 266>;
 				st,bank-name = "GPIOK";
 			};
+
+			usart1_pins_a: usart1 at 0 {
+				pins1 {
+					pinmux = <STM32F429_PA9_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F429_PA10_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
 		};
 
 		rcc: rcc at 40023810 {
-- 
1.9.1
