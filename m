From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Aug 2015 01:00:09 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add I2C DT support
In-Reply-To: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
References: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
Message-ID: <1683106.jUSrvORJGA@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 parts of the I2C[0-5] device nodes.

Based on the original patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi |   73 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -20,6 +20,12 @@
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
 		spi0 = &qspi;
 	};
 
@@ -500,6 +506,73 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+	};
+
+	/* The memory map in the User's Manual maps the cores to bus numbers */
+	i2c0: i2c at e6508000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at e6518000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at e6530000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at e6540000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c4: i2c at e6520000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6520000 0 0x40>;
+		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C4>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c at e6528000 {
+		compatible = "renesas,i2c-r8a7794";
+		reg = <0 0xe6528000 0 0x40>;
+		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_I2C5>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	mmcif0: mmc at ee200000 {
