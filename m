From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  1 Feb 2014 16:46:16 +0100
Subject: [PATCH] ARM: sun7i: dt: Fix interrupt trigger types
Message-ID: <1391269576-13274-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A20 uses the ARM GIC as its internal interrupts controller. The
GIC can work on several interrupt triggers, and the A20 was actually setting it
up to use a rising edge as a trigger, while it was actually a level high
trigger, leading to some interrupts that would be completely ignored if the
edge was missed.

Fix this for the remaining DT nodes that slipped through.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: stable at vger.kernel.org
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..2374f5a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -454,7 +454,7 @@
 		rtc: rtc at 01c20d00 {
 			compatible = "allwinner,sun7i-a20-rtc";
 			reg = <0x01c20d00 0x20>;
-			interrupts = <0 24 1>;
+			interrupts = <0 24 4>;
 		};
 
 		sid: eeprom at 01c23800 {
@@ -596,10 +596,10 @@
 		hstimer at 01c60000 {
 			compatible = "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
-			interrupts = <0 81 1>,
-				     <0 82 1>,
-				     <0 83 1>,
-				     <0 84 1>;
+			interrupts = <0 81 4>,
+				     <0 82 4>,
+				     <0 83 4>,
+				     <0 84 4>;
 			clocks = <&ahb_gates 28>;
 		};
 
-- 
1.8.4.2
