From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 1 Nov 2012 10:49:25 -0500
Subject: [PATCH 1/3] ARM: dts: Update OMAP4 timer addresses
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1351784967-32520-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For OMAP4 devices, timers 5-8 have both a L3 bus address and a Cortex-A9
private bus address. Currently the device-tree source only contains the
L3 bus address for these timers. Update these timers to include the
Cortex-A9 private address and make the default address the Cortex-A9
private bus address to match the current HWMOD implementation.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 23ee149..739bb79 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -469,33 +469,37 @@
 			ti,hwmods = "timer4";
 		};
 
-		timer5: timer at 49038000 {
+		timer5: timer at 40138000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x49038000 0x80>;
+			reg = <0x40138000 0x80>,
+			      <0x49038000 0x80>;
 			interrupts = <0 41 0x4>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
 		};
 
-		timer6: timer at 4903a000 {
+		timer6: timer at 4013a000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903a000 0x80>;
+			reg = <0x4013a000 0x80>,
+			      <0x4903a000 0x80>;
 			interrupts = <0 42 0x4>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
 		};
 
-		timer7: timer at 4903c000 {
+		timer7: timer at 4013c000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903c000 0x80>;
+			reg = <0x4013c000 0x80>,
+			      <0x4903c000 0x80>;
 			interrupts = <0 43 0x4>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
 		};
 
-		timer8: timer at 4903e000 {
+		timer8: timer at 4013e000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903e000 0x80>;
+			reg = <0x4013e000 0x80>,
+			      <0x4903e000 0x80>;
 			interrupts = <0 44 0x4>;
 			ti,hwmods = "timer8";
 			ti,timer-pwm;
-- 
1.7.9.5
