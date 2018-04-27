From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 27 Apr 2018 17:28:32 +0800
Subject: [PATCH] ARM: dts: berlin2q: add interrupt-affinity to pmu node
Message-ID: <20180427172832.48840c3c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt-affinity property to fix below warning:
[    0.429642] CPU PMU: Failed to parse /soc/pmu/interrupt-affinity[0]

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index bf3a6c9a1d34..e23c49ae3ec2 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -53,7 +53,7 @@
 		#size-cells = <0>;
 		enable-method = "marvell,berlin-smp";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
@@ -71,21 +71,21 @@
 			>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <1>;
 		};
 
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <2>;
 		};
 
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			next-level-cache = <&l2>;
@@ -113,6 +113,10 @@
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&cpu0>,
+					     <&cpu1>,
+					     <&cpu2>,
+					     <&cpu3>;
 		};
 
 		sdhci0: sdhci at ab0000 {
-- 
2.17.0
