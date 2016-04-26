From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 14:27:18 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: add shutdown controller node
Message-ID: <1461673638-14644-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SAMA5D2-Compatible Shutdown Controller node to sama5d2.dtsi
and the use of it in the sama5d2 Xplained board dts file.

Enable the RTC wakeup event and the "wake up" button support through the
input "0" that is present on the board.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 9 +++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 21c780fab761..eb4f1ac96271 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -234,6 +234,15 @@
 				};
 			};
 
+			shdwc at f8048010 {
+				atmel,shdwc-debouncer = <976>;
+
+				input at 0 {
+					reg = <0>;
+					atmel,wakeup-type = "low";
+				};
+			};
+
 			watchdog at f8048040 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 12cc1d34097d..43015c2ad395 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1030,6 +1030,15 @@
 				clocks = <&clk32k>;
 			};
 
+			shdwc at f8048010 {
+				compatible = "atmel,sama5d2-shdwc";
+				reg = <0xf8048010 0x10>;
+				clocks = <&clk32k>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,wakeup-rtc-timer;
+			};
+
 			pit: timer at f8048030 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xf8048030 0x10>;
-- 
2.1.3
