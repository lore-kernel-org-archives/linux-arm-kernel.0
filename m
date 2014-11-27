From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 27 Nov 2014 14:36:45 +0000
Subject: [PATCH] arm64: ARM: Fix the Generic Timers interrupt active level
 description
Message-ID: <1417099005-18638-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A5x TRM states in paragraph "9.2 Generic Timer functional
description" that generic timers provide an active-LOW interrupt
output. Fix the device trees to correctly describe this.

While doing this update the CPU mask to match the number of described
CPUs as well.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---

Arnd, Olof: This is on top of linux-next/master as it patches the Juno
as well as all the other ARM DTs.

 arch/arm64/boot/dts/arm/foundation-v8.dts  | 8 ++++----
 arch/arm64/boot/dts/arm/juno.dts           | 8 ++++----
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4a06090..27f3296 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -78,10 +78,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xff01>,
-			     <1 14 0xff01>,
-			     <1 11 0xff01>,
-			     <1 10 0xff01>;
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
 		clock-frequency = <100000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 097ecc4..cb3073e 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -98,10 +98,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index 572005e..efc59b3 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -81,10 +81,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xff01>,
-			     <1 14 0xff01>,
-			     <1 11 0xff01>,
-			     <1 10 0xff01>;
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
 		clock-frequency = <100000000>;
 	};
 
-- 
2.1.3
