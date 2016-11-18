From: bruherrera@gmail.com (Bruno Meirelles Herrera)
Date: Fri, 18 Nov 2016 13:10:33 -0200
Subject: [RESEND PATCH v1] ARM: dts: stm32f429: Add missing USART3 pin config
 to STM32F469I-DISCO board
Message-ID: <20161118151033.30592-1-bmh@certi.org.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including new STM32 maintainer. Rebased at stm32-dt-for-v4.10-1 and
stm32-dt-for-v4.10-2 branches. It fix the port/pin initialization in
case boot-loader does not configure/initialize the pins. 
Fixing line wrapping from last patch

This patch adds USART3 pin configuration on PB10/PA11 pins
for STM32F469I-DISCO board.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      | 13 +++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..1b8b105 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -316,6 +316,19 @@
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
index 8877c00..75f4303 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -79,5 +79,7 @@
 };
 
 &usart3 {
+	pinctrl-0 = <&usart3_pins_a>;
+	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.9.3 (Apple Git-75)
