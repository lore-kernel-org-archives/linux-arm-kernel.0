From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 30 Jul 2018 21:22:37 +0300
Subject: [PATCH] arm64: dts: renesas: r8a779{7|8}0: move CAN clock node
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <fe596579-e541-f061-4ef7-bf850b24153a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CAN clock node should precede the "cpus" node in the R8A779{7|8}0
device  trees,  according to  the alphanumeric node sorting rule...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20180726-v4.18-rc6' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   14 +++++++-------
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
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
Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
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
