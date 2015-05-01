From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri,  1 May 2015 19:11:26 +0200
Subject: [PATCH] ARM: vexpress: Add interrupt-affinity
Message-ID: <1430500286-10337-1-git-send-email-r.schwebel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9fd85eb502a7 ("ARM: pmu: add support for interrupt-affinity
property") added an optional "interrupt-affinity" property, to specify
the CPU affinity for each SPI listed in the interrupts property.

Without this property, we get this boot warning:

  CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]

This patch adds interrupt-affinity to the PMU node in the
vexpress-v2p-ca9 device tree.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index a411274..9d71493 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -33,28 +33,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		A9_0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
 
-		cpu at 1 {
+		A9_1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			next-level-cache = <&L2>;
 		};
 
-		cpu at 2 {
+		A9_2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			next-level-cache = <&L2>;
 		};
 
-		cpu at 3 {
+		A9_3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
@@ -182,6 +182,11 @@
 			     <0 61 4>,
 			     <0 62 4>,
 			     <0 63 4>;
+		interrupt-affinity = <&A9_0>,
+		                     <&A9_1>,
+		                     <&A9_2>,
+		                     <&A9_3>;
+
 	};
 
 	dcc {
-- 
2.1.4
