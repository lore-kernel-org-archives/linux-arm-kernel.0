From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:30 +0200
Subject: [PATCH 57/69] ARM: dts: emev2: Add missing interrupt-affinity to PMU
 node
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <7207b94754b6f503b278b5b200faaf662ffa1da8.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The PMU node references two interrupts, but lacks the interrupt-affinity
property, which is required in that case:

    hw perfevents: no interrupt-affinity property for /pmu, guessing.

Add the missing property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 42ea246e71cb..fec1241b858f 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -31,13 +31,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <533000000>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
@@ -57,6 +57,7 @@
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
 	clocks at e0110000 {
-- 
2.11.0
