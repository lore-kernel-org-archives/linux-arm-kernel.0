From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:03 +0200
Subject: [PATCH 08/58] arm64: dts: renesas: r8a779{7|8}0: move CAN clock node
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <18281dec2ba086b93bee2dd5f9ee0e3633d25a8d.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The CAN clock node should precede the "cpus" node in the R8A779{7|8}0
device  trees,  according to  the alphanumeric node sorting rule...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 18d1aafe2e30..6c0832f23811 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -24,6 +24,13 @@
 		i2c4 = &i2c4;
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -82,13 +89,6 @@
 		method = "smc";
 	};
 
-	/* External CAN clock - to be overridden by boards that provide it */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	/* External SCIF clock - to be overridden by boards that provide it */
 	scif_clk: scif {
 		compatible = "fixed-clock";
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index fbfe65476443..4bc99d6763ce 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -25,6 +25,13 @@
 		i2c5 = &i2c5;
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -77,13 +84,6 @@
 		};
 	};
 
-	/* External CAN clock - to be overridden by boards that provide it */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.11.0
