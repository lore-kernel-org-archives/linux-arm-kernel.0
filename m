From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:13:01 +0100
Subject: [PATCH v2 08/11] Documentation: bindings: update the berlin chip and
 system ctrl doc
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the rework to have one sub-node per device in the chip and
system controllers is done, their dedicated compatible can be removed.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell,berlin.txt | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 4a8ff8e14cb7..b76838ab4f51 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -50,11 +50,7 @@ different functions which are described below.
 
 Required properties:
 - compatible:
-	* the first value should be one of:
-		"marvell,berlin2-chip-ctrl" for BG2
-		"marvell,berlin2cd-chip-ctrl" for BG2CD
-		"marvell,berlin2q-chip-ctrl" for BG2Q
-	* the second and third values must be:
+	* the first and second values must be:
 		"simple-mfd", "syscon"
 - reg: address and length of following register sets for
   BG2/BG2CD: chip control register set
@@ -67,25 +63,21 @@ individual registers dealing with pinmux, padmux, and reset.
 
 Required properties:
 - compatible:
-	* the first value should be one of:
-		"marvell,berlin2-system-ctrl" for BG2
-		"marvell,berlin2cd-system-ctrl" for BG2CD
-		"marvell,berlin2q-system-ctrl" for BG2Q
-	* the second and third values must be:
+	* the first and second values must be:
 		"simple-mfd", "syscon"
 - reg: address and length of the system control register set
 
 Example:
 
 chip: chip-control at ea0000 {
-	compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
+	compatible = "simple-mfd", "syscon";
 	reg = <0xea0000 0x400>;
 
 	/* sub-device nodes */
 };
 
 sysctrl: system-controller at d000 {
-	compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
+	compatible = "simple-mfd", "syscon";
 	reg = <0xd000 0x100>;
 
 	/* sub-device nodes */
-- 
2.3.1
