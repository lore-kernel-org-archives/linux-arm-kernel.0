From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue,  7 Jun 2016 22:01:48 -0300
Subject: [PATCH] ARM: dts: stm32f429: Add missing USART3 pin config to
 STM32F469I-DISCO board
Message-ID: <1465347708-65658-1-git-send-email-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USART3 pin configuration on PB10/PA11 pins 
for STM32F469I-DISCO board.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      | 13 +++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..1d94eba 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -284,6 +284,19 @@
 				};
 			};
 
+			usart3_pins_a: usart3 at 0 {
+				pins1 {
+					pinmux = <STM32F429_PB10_FUNC_USART3_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F429_PB11_FUNC_USART3_RX>;
+					bias-disable;
+				};
+			};
+
 			usbotg_hs_pins_a: usbotg_hs at 0 {
 				pins {
 					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index e911af8..eb3e638 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -71,5 +71,7 @@
 };
 
 &usart3 {
+	pinctrl-0 = <&usart3_pins_a>;
+	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.7.4 (Apple Git-66)
