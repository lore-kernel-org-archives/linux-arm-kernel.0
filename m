From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Aug 2014 00:16:18 +0400
Subject: [PATCH v5 1/2] ARM: shmobile: r8a7790: add VIN device nodes
In-Reply-To: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
References: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
Message-ID: <3266734.k9AqsXjshd@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add device nodes for the four video input controllers on the R8A7790.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[Sergei: renamed VIN device nodes, edited changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 5:
- renamed VIN device nodes;
- edited changelog and summary;
- refreshed patch.

 arch/arm/boot/dts/r8a7790.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -33,6 +33,10 @@
 		spi2 = &msiof1;
 		spi3 = &msiof2;
 		spi4 = &msiof3;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
+		vin3 = &vin3;
 	};
 
 	cpus {
@@ -564,6 +568,38 @@
 		status = "disabled";
 	};
 
+	vin0: video at e6ef0000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
+		reg = <0 0xe6ef0000 0 0x1000>;
+		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin1: video at e6ef1000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
+		reg = <0 0xe6ef1000 0 0x1000>;
+		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin2: video at e6ef2000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
+		reg = <0 0xe6ef2000 0 0x1000>;
+		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin3: video at e6ef3000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
+		reg = <0 0xe6ef3000 0 0x1000>;
+		interrupts = <0 191 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
