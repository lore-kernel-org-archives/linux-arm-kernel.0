From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Wed, 31 May 2017 12:23:12 +0300
Subject: [PATCH v3] ARM: dts: at91: sama5d2_xplained: add pwm controller
Message-ID: <1496222592-19375-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm controller bindings for sama5d2_xplained
and enable it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v3:
- enable pwm in at91-sama5d2_xplained.dts file

Changes in v2:
- Correct the typo in patch subject.

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ++++
 arch/arm/boot/dts/sama5d2.dtsi              | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0bef9e0..558b0af 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -227,6 +227,10 @@
 				};
 			};
 
+			pwm0: pwm at f802c000 {
+				status = "okay";
+			};
+
 			flx0: flexcom at f8034000 {
 				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
 				status = "disabled"; /* conflict with ISC_D2 & ISC_D3 data pins */
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..bf21b63 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1065,6 +1065,14 @@
 				status = "disabled";
 			};
 
+			pwm0: pwm at f802c000 {
+				compatible = "atmel,sama5d2-pwm";
+				reg = <0xf802c000 0x4000>;
+				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 7>;
+				#pwm-cells = <3>;
+				clocks = <&pwm_clk>;
+			};
+
 			sfr: sfr at f8030000 {
 				compatible = "atmel,sama5d2-sfr", "syscon";
 				reg = <0xf8030000 0x98>;
-- 
2.7.4
