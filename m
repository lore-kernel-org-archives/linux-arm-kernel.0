From: carlo@caione.org (Carlo Caione)
Date: Thu,  1 Oct 2015 12:52:40 +0200
Subject: [PATCH] ARM: meson6: DTS: Fix wrong reg mapping and IRQ numbers
Message-ID: <1443696760-8316-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The DTS erronously uses the wrong reg mapping and IRQ numbers for some
UART, WDT and timer nodes. Fix this.

Reported-by: John Wehle <john@feith.com>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson.dtsi | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 5484413..8c77c87 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -67,7 +67,7 @@
 
 	timer at c1109940 {
 		compatible = "amlogic,meson6-timer";
-		reg = <0xc1109940 0x14>;
+		reg = <0xc1109940 0x18>;
 		interrupts = <0 10 1>;
 	};
 
@@ -80,36 +80,37 @@
 		wdt: watchdog at c1109900 {
 			compatible = "amlogic,meson6-wdt";
 			reg = <0xc1109900 0x8>;
+			interrupts = <0 0 1>;
 		};
 
 		uart_AO: serial at c81004c0 {
 			compatible = "amlogic,meson-uart";
-			reg = <0xc81004c0 0x14>;
+			reg = <0xc81004c0 0x18>;
 			interrupts = <0 90 1>;
 			clocks = <&clk81>;
 			status = "disabled";
 		};
 
-		uart_A: serial at c81084c0 {
+		uart_A: serial at c11084c0 {
 			compatible = "amlogic,meson-uart";
-			reg = <0xc81084c0 0x14>;
-			interrupts = <0 90 1>;
+			reg = <0xc11084c0 0x18>;
+			interrupts = <0 26 1>;
 			clocks = <&clk81>;
 			status = "disabled";
 		};
 
-		uart_B: serial at c81084dc {
+		uart_B: serial at c11084dc {
 			compatible = "amlogic,meson-uart";
-			reg = <0xc81084dc 0x14>;
-			interrupts = <0 90 1>;
+			reg = <0xc11084dc 0x18>;
+			interrupts = <0 75 1>;
 			clocks = <&clk81>;
 			status = "disabled";
 		};
 
-		uart_C: serial at c8108700 {
+		uart_C: serial at c1108700 {
 			compatible = "amlogic,meson-uart";
-			reg = <0xc8108700 0x14>;
-			interrupts = <0 90 1>;
+			reg = <0xc1108700 0x18>;
+			interrupts = <0 93 1>;
 			clocks = <&clk81>;
 			status = "disabled";
 		};
-- 
1.9.1
