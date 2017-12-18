From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Dec 2017 22:32:32 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7792: sort root sub-nodes alphabetically
In-Reply-To: <20171218213233.3373-1-horms+renesas@verge.net.au>
References: <20171218213233.3373-1-horms+renesas@verge.net.au>
Message-ID: <20171218213233.3373-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort root sub-nodes alphabetically for allow for easier maintenance
of this file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index ac05fdb91798..d31258958c36 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -36,6 +36,22 @@
 		vin5 = &vin5;
 	};
 
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -69,6 +85,14 @@
 		};
 	};
 
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -833,28 +857,4 @@
 			#reset-cells = <1>;
 		};
 	};
-
-	/* External root clock */
-	extal_clk: extal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
-
-	/* External SCIF clock */
-	scif_clk: scif {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
-
-	/* External CAN clock */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
 };
-- 
2.11.0
