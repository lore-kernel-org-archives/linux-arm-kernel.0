From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:39 +0900
Subject: [PATCH 65/69] ARM: shmobile: Use r8a7740 suffix for INTC compat string
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <96327999805dfb5b6e91e6969311d9a77a0160cd.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7740" to the compatible string for the
IRQ pins in case of r8a7740 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 52255bf..2782f64 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -41,7 +41,7 @@
 
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin at e6900000 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900000 4>,
@@ -62,7 +62,7 @@
 
 	/* irqpin1: IRQ8 - IRQ15 */
 	irqpin1: irqpin at e6900004 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900004 4>,
@@ -83,7 +83,7 @@
 
 	/* irqpin2: IRQ16 - IRQ23 */
 	irqpin2: irqpin at e6900008 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900008 4>,
@@ -104,7 +104,7 @@
 
 	/* irqpin3: IRQ24 - IRQ31 */
 	irqpin3: irqpin at e690000c {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe690000c 4>,
-- 
1.8.4
