From: s-anna@ti.com (Suman Anna)
Date: Mon, 16 Mar 2015 12:20:37 -0500
Subject: [PATCH] ARM: dts: DRA7: Remove ti, timer-dsp and ti,
 timer-pwm properties
Message-ID: <1426526437-63741-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the 'ti,timer-dsp' and 'ti,timer-pwm' properties from the timer
nodes that still have them. This seems to be copied from OMAP5, on
which only certain timers are capable of providing PWM functionality
or be able to interrupt the DSP. All the GPTimers On DRA7 are capable
of PWM and interrupting any core (due to the presence of Crossbar).

These properties were used by the driver to add capabilities to each
timer, and support requesting timers by capability. In the DT world,
we expect any users of timers to use phandles to the respective timer,
and use the omap_dm_timer_request_by_node() API. The API to request
using capabilities, omap_dm_timer_request_by_cap() API should be
deprecated eventually.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fedafd43..318d9409e8cd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -658,7 +658,6 @@
 			reg = <0x48820000 0x80>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
-			ti,timer-dsp;
 		};
 
 		timer6: timer at 48822000 {
@@ -666,8 +665,6 @@
 			reg = <0x48822000 0x80>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
-			ti,timer-dsp;
-			ti,timer-pwm;
 		};
 
 		timer7: timer at 48824000 {
@@ -675,7 +672,6 @@
 			reg = <0x48824000 0x80>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
-			ti,timer-dsp;
 		};
 
 		timer8: timer at 48826000 {
@@ -683,8 +679,6 @@
 			reg = <0x48826000 0x80>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
-			ti,timer-dsp;
-			ti,timer-pwm;
 		};
 
 		timer9: timer at 4803e000 {
@@ -706,7 +700,6 @@
 			reg = <0x48088000 0x80>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
-			ti,timer-pwm;
 		};
 
 		timer13: timer at 48828000 {
-- 
2.3.2
