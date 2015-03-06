From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:19 +0100
Subject: [PATCH v2 01/10] Documentation: bindings: update the Berlin
 controllers documentation
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're moving from a single node for multiple devices to a node with one
sub-node per sub-device, registered by simple-mfd. Update the
documentation to reflect the changes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 26 +++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index a99eb9eb14c0..3a7fce4dc4af 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -49,10 +49,13 @@ chip control registers, so there should be a single DT node only providing the
 different functions which are described below.
 
 Required properties:
-- compatible: shall be one of
-	"marvell,berlin2-chip-ctrl" for BG2
-	"marvell,berlin2cd-chip-ctrl" for BG2CD
-	"marvell,berlin2q-chip-ctrl" for BG2Q
+- compatible:
+	* the first value should be one of:
+		"marvell,berlin2-chip-ctrl" for BG2
+		"marvell,berlin2cd-chip-ctrl" for BG2CD
+		"marvell,berlin2q-chip-ctrl" for BG2Q
+	* the second and third values must be:
+		"simple-mfd", "syscon"
 - reg: address and length of following register sets for
   BG2/BG2CD: chip control register set
   BG2Q: chip control register set and cpu pll registers
@@ -63,10 +66,13 @@ Marvell Berlin SoCs have a system control register set providing several
 individual registers dealing with pinmux, padmux, and reset.
 
 Required properties:
-- compatible: should be one of
-	"marvell,berlin2-system-ctrl" for BG2
-	"marvell,berlin2cd-system-ctrl" for BG2CD
-	"marvell,berlin2q-system-ctrl" for BG2Q
+- compatible:
+	* the first value should be one of:
+		"marvell,berlin2-system-ctrl" for BG2
+		"marvell,berlin2cd-system-ctrl" for BG2CD
+		"marvell,berlin2q-system-ctrl" for BG2Q
+	* the second and third values must be:
+		"simple-mfd", "syscon"
 - reg: address and length of the system control register set
 
 * Clock provider binding
@@ -118,7 +124,7 @@ Required property:
 Example:
 
 chip: chip-control at ea0000 {
-	compatible = "marvell,berlin2-chip-ctrl";
+	compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
 	#clock-cells = <1>;
 	#reset-cells = <2>;
 	reg = <0xea0000 0x400>;
@@ -132,7 +138,7 @@ chip: chip-control at ea0000 {
 };
 
 sysctrl: system-controller at d000 {
-	compatible = "marvell,berlin2-system-ctrl";
+	compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
 	reg = <0xd000 0x100>;
 
 	uart0_pmux: uart0-pmux {
-- 
2.3.1
