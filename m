From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Apr 2018 13:43:56 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: use CPG core clock macros
In-Reply-To: <ea6d3e8a-71a9-9998-f364-7dc82b97c2c0@cogentembedded.com>
References: <ea6d3e8a-71a9-9998-f364-7dc82b97c2c0@cogentembedded.com>
Message-ID: <0fa354d7-2403-1d41-49f0-1502912f5656@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the commit 35b3c462dae1 ("dt-bindings: clock: add R8A77980 CPG
core clock definitions") has hit Linus' tree, we can replace the bare
numbers (we had to use to avoid a cross tree dependency) with these macro
definitions...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -6,9 +6,9 @@
  * Copyright (C) 2018 Cogent Embedded, Inc.
  */
 
+#include <dt-bindings/clock/r8a77980-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
 
 / {
 	compatible = "renesas,r8a77980";
@@ -23,7 +23,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
-			clocks = <&cpg CPG_CORE 0>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
 			power-domains = <&sysc 5>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
@@ -104,7 +104,7 @@
 			reg = <0 0xe6540000 0 0x60>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
@@ -122,7 +122,7 @@
 			reg = <0 0xe6550000 0 0x60>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
@@ -140,7 +140,7 @@
 			reg = <0 0xe6560000 0 0x60>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
@@ -158,7 +158,7 @@
 			reg = <0 0xe66a0000 0 0x60>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x37>, <&dmac1 0x36>,
@@ -220,7 +220,7 @@
 			reg = <0 0xe6e60000 0 0x40>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
@@ -238,7 +238,7 @@
 			reg = <0 0xe6e68000 0 0x40>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
@@ -256,7 +256,7 @@
 			reg = <0 0xe6c50000 0 0x40>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x57>, <&dmac1 0x56>,
@@ -274,7 +274,7 @@
 			reg = <0 0xe6c40000 0 0x40>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>,
-				 <&cpg CPG_CORE 19>,
+				 <&cpg CPG_CORE R8A77980_CLK_S3D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x59>, <&dmac1 0x58>,
