From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 28 Dec 2015 15:52:04 +0200
Subject: [PATCH] ARM: dts: am4372: fix irq type for arm twd and global timer
Message-ID: <1451310724-29454-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per ARM documentation
PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
PPI(2) ID29 - twd interrupt is rising-edge sensitive.

and the same is proved by GIC distributor register value
GIC_DIST_CONFIG(0xC04) = 0x7DC00000.

Hence, set IRQ triggering type to IRQ_TYPE_EDGE_RISING
for ARM TWD and Global timers.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index de8791a..dfa1a29 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -72,7 +72,7 @@
 	global_timer: timer at 48240200 {
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x48240200 0x100>;
-		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 		interrupt-parent = <&gic>;
 		clocks = <&mpu_periphclk>;
 	};
@@ -80,7 +80,7 @@
 	local_timer: timer at 48240600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x48240600 0x100>;
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>;
 		interrupt-parent = <&gic>;
 		clocks = <&mpu_periphclk>;
 	};
-- 
2.6.4
