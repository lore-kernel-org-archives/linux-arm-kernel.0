From: bruherrera@gmail.com (Bruno Herrera)
Date: Fri, 18 Nov 2016 11:13:29 -0200
Subject: [RESEND PATCH] ARM: dts: stm32f429: Add missing USART3 pin config to
 STM32F469I-DISCO board
Message-ID: <CAF3+Tqer616rqU6rKeSKF5vusTdNSAQ_okCgRtx8ZnhOjjK78g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including new STM32 maintainer. Rebased at stm32-dt-for-v4.10-1 and
stm32-dt-for-v4.10-2 branches. It fix the port/pin initialization in
case boot-loader does not configure/initialize the pins.

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

+                       usart3_pins_a: usart3 at 0 {
+                               pins1 {
+                                       pinmux =
<STM32F429_PB10_FUNC_USART3_TX>;
+                                       bias-disable;
+                                       drive-push-pull;
+                                       slew-rate = <0>;
+                               };
+                               pins2 {
+                                       pinmux =
<STM32F429_PB11_FUNC_USART3_RX>;
+                                       bias-disable;
+                               };
+                       };
+
                        usbotg_hs_pins_a: usbotg_hs at 0 {
                                pins {
                                        pinmux =
<STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
b/arch/arm/boot/dts/stm32f469-disco.dts
index e911af8..eb3e638 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -71,5 +71,7 @@
 };

 &usart3 {
+       pinctrl-0 = <&usart3_pins_a>;
+       pinctrl-names = "default";
        status = "okay";
 };


--
2.7.4 (Apple Git-66)
