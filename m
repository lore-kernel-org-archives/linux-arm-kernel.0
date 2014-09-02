From: evanluijk@interact.nl (Erik van Luijk)
Date: Tue,  2 Sep 2014 12:52:12 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9m10g45ek add rtc node
Message-ID: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Erik van Luijk <evanluijk@interact.nl>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     | 7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 932a669..bf62c18 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1070,6 +1070,13 @@
 				status = "disabled";
 			};
 
+			rtc at fffffdb0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfffffdb0 0x30>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				status = "disabled";
+			};
+
 			spi0: spi at fffa4000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 96ccc7d..2dd2347 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -70,6 +70,9 @@
 
 			watchdog at fffffd40 {
 				status = "okay";
+
+			rtc at fffffdb0 {
+				status = "okay";
 			};
 
 			mmc0: mmc at fff80000 {
-- 
1.9.1
