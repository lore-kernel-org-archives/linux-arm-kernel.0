From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 May 2015 15:45:04 +0100
Subject: [PATCH 3/4] ARM: vexpress/ca9: Add interrupt-affinity to the PMU node
In-Reply-To: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
References: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431009905-29265-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Schwebel <r.schwebel@pengutronix.de>

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
 arch/arm/boot/dts/vexpress-v2p-ca9.dts | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index a411274e8b6b..d949facba376 100644
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
@@ -182,6 +182,8 @@
 			     <0 61 4>,
 			     <0 62 4>,
 			     <0 63 4>;
+		interrupt-affinity = <&A9_0>, <&A9_1>, <&A9_2>, <&A9_3>;
+
 	};
 
 	dcc {
-- 
1.9.1
