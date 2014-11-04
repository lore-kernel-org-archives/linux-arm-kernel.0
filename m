From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:39 +0900
Subject: [PATCH 09/34] ARM: shmobile: r8a7790: switch from scif to scifa
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <7c05589413fa9902f2843e91845d6084f6f8e2cd.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

SCIF and SCIFA can be plexed onto the same wires on Lager board. The
datasheet also describes the wires as SCIFA. So, to make use of the
bigger FIFOs switch to SCIFA instead.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index cd530de..e96f952 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -19,8 +19,8 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial6 = &scif0;
-		serial7 = &scif1;
+		serial6 = &scifa0;
+		serial7 = &scifa1;
 	};
 
 	chosen {
@@ -207,9 +207,9 @@
 		renesas,function = "du";
 	};
 
-	scif0_pins: serial0 {
-		renesas,groups = "scif0_data";
-		renesas,function = "scif0";
+	scifa0_pins: serial0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
 	};
 
 	ether_pins: ether {
@@ -222,9 +222,9 @@
 		renesas,function = "intc";
 	};
 
-	scif1_pins: serial1 {
-		renesas,groups = "scif1_data";
-		renesas,function = "scif1";
+	scifa1_pins: serial1 {
+		renesas,groups = "scifa1_data";
+		renesas,function = "scifa1";
 	};
 
 	sdhi0_pins: sd0 {
@@ -356,15 +356,15 @@
 	};
 };
 
-&scif0 {
-	pinctrl-0 = <&scif0_pins>;
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
 };
 
-&scif1 {
-	pinctrl-0 = <&scif1_pins>;
+&scifa1 {
+	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
-- 
2.1.1
