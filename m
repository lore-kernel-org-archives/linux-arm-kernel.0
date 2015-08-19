From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Aug 2015 01:22:24 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add VIN DT support
In-Reply-To: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
Message-ID: <6082759.38ZG7ZtnPq@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 part of the VIN[01] device nodes. Add aliases for
the VIN[01] device nodes. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -27,6 +27,8 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		spi0 = &qspi;
+		vin0 = &vin0;
+		vin1 = &vin1;
 	};
 
 	cpus {
@@ -628,6 +630,24 @@
 		status = "disabled";
 	};
 
+	vin0: video at e6ef0000 {
+		compatible = "renesas,vin-r8a7794";
+		reg = <0 0xe6ef0000 0 0x1000>;
+		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	vin1: video at e6ef1000 {
+		compatible = "renesas,vin-r8a7794";
+		reg = <0 0xe6ef1000 0 0x1000>;
+		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
