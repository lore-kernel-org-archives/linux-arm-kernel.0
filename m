From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:55 +0100
Subject: [PATCH 22/25] arm: atlas: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124656.31002-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/atlas6.dtsi |  2 +-
 arch/arm/boot/dts/atlas7.dtsi | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 29598667420b..b19d5a6368c9 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -293,7 +293,7 @@
 				#dma-cells = <1>;
 			};
 
-			vip at b00C0000 {
+			vip at b00c0000 {
 				compatible = "sirf,prima2-vip";
 				reg = <0xb00C0000 0x10000>;
 				clocks = <&clks 31>;
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 83449b33de6b..97a24248c988 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -76,7 +76,7 @@
 			     <0x10302000 0x0100>;
 		};
 
-		pmu_regulator: pmu_regulator at 10E30020 {
+		pmu_regulator: pmu_regulator at 10e30020 {
 			compatible = "sirf,atlas7-pmu-ldo";
 			reg = <0x10E30020 0x4>;
 			ldo: ldo {
@@ -84,7 +84,7 @@
 			};
 		};
 
-		atlas7_codec: atlas7_codec at 10E30000 {
+		atlas7_codec: atlas7_codec at 10e30000 {
 			#sound-dai-cells = <0>;
 			compatible = "sirf,atlas7-codec";
 			reg = <0x10E30000 0x400>;
@@ -92,7 +92,7 @@
 			ldo-supply = <&ldo>;
 		};
 
-		atlas7_iacc: atlas7_iacc at 10D01000 {
+		atlas7_iacc: atlas7_iacc at 10d01000 {
 			#sound-dai-cells = <0>;
 			compatible = "sirf,atlas7-iacc";
 			reg = <0x10D01000 0x100>;
@@ -1170,7 +1170,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13240000 0x13240000 0x00010000>;
-			pmipc at 0x13240000 {
+			pmipc at 13240000 {
 				compatible = "sirf,atlas7-pmipc";
 				reg = <0x13240000 0x00010000>;
 			};
@@ -1265,7 +1265,7 @@
 				#dma-cells = <1>;
 			};
 
-			gnssmfw at 0x18100000 {
+			gnssmfw at 18100000 {
 				compatible = "sirf,nocfw-gnssm";
 				reg = <0x18100000 0x3000>;
 			};
@@ -1374,7 +1374,7 @@
 				<0x13010000 0x13010000 0x1400>,
 				<0x13010800 0x13010800 0x100>,
 				<0x13011000 0x13011000 0x100>;
-			gpum at 0x13000000 {
+			gpum at 13000000 {
 				compatible = "sirf,nocfw-gpum";
 				reg = <0x13000000 0x3000>;
 			};
@@ -1396,7 +1396,7 @@
 				#dma-cells = <1>;
 				#dma-channels = <1>;
 			};
-			sdr at 0x13010000 {
+			sdr at 13010000 {
 				compatible = "sirf,atlas7-sdr";
 				reg = <0x13010000 0x1400>;
 				interrupts = <0 7 0>,
@@ -1432,7 +1432,7 @@
 				clocks = <&car 102>;
 			};
 
-			mediam at 170A0000 {
+			mediam at 170a0000 {
 				compatible = "sirf,nocfw-mediam";
 				reg = <0x170A0000 0x3000>;
 			};
@@ -1740,7 +1740,7 @@
 				clocks = <&car 54>;
 			};
 
-			audiom at 10ED0000 {
+			audiom at 10ed0000 {
 				compatible = "sirf,nocfw-audiom";
 				reg = <0x10ED0000 0x3000>;
 				interrupts = <0 102 0>;
@@ -1780,7 +1780,7 @@
 				interrupts = <0 105 0>;
 			};
 
-			memory-controller at 0x10800000 {
+			memory-controller at 10800000 {
 				compatible = "sirf,atlas7-memc";
 				reg = <0x10800000 0x2000>;
 			};
@@ -1887,7 +1887,7 @@
 				};
 			};
 
-			qspi: flash at 188B0000 {
+			qspi: flash at 188b0000 {
 				cell-index = <0>;
 				compatible = "sirf,atlas7-qspi-nor";
 				reg = <0x188B0000 0x10000>;
@@ -1896,7 +1896,7 @@
 				#size-cells = <0>;
 			};
 
-			retain at 0x188D0000 {
+			retain at 188d0000 {
 				compatible = "sirf,atlas7-retain";
 				reg = <0x188D0000 0x1000>;
 			};
-- 
2.11.0
