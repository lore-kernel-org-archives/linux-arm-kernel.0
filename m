From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 11 Aug 2015 00:59:24 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7794: add QSPI DT support
In-Reply-To: <4187771.Fb49GBKgyg@wasted.cogentembedded.com>
References: <4187771.Fb49GBKgyg@wasted.cogentembedded.com>
Message-ID: <1540672.y3DTbtssP8@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7794 part of the QSPI device node.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- moved the "power-domains" property after the DMA properties.

 arch/arm/boot/dts/r8a7794.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -19,6 +19,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		spi0 = &qspi;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -537,6 +541,20 @@
 		status = "disabled";
 	};
 
+	qspi: spi at e6b10000 {
+		compatible = "renesas,qspi-r8a7794", "renesas,qspi";
+		reg = <0 0xe6b10000 0 0x2c>;
+		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
+		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
