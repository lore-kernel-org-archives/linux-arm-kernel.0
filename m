From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:34 +0100
Subject: [PATCH 64/69] arm64: dts: renesas: r8a77970: add I2C support
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <cbfa278e20913a9b8380278149fa7e4068ea82e2.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A77970 parts of the I2C[0-4] device node.

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 93 +++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 13ff4305416e..e44281cc1047 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -19,6 +19,14 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -338,6 +346,91 @@
 			       <&ipmmu_ds1 22>, <&ipmmu_ds1 23>;
 		};
 
+		i2c0: i2c at e6500000 {
+			compatible = "renesas,i2c-r8a77970",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6500000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
+			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
+			       <&dmac2 0x91>, <&dmac2 0x90>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6508000 {
+			compatible = "renesas,i2c-r8a77970",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
+			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
+			       <&dmac2 0x93>, <&dmac2 0x92>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at e6510000 {
+			compatible = "renesas,i2c-r8a77970",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6510000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
+			       <&dmac2 0x95>, <&dmac2 0x94>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e66d0000 {
+			compatible = "renesas,i2c-r8a77970",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66d0000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			dmas = <&dmac1 0x97>, <&dmac1 0x96>,
+			       <&dmac2 0x97>, <&dmac2 0x96>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at e66d8000 {
+			compatible = "renesas,i2c-r8a77970",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66d8000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			dmas = <&dmac1 0x99>, <&dmac1 0x98>,
+			       <&dmac2 0x99>, <&dmac2 0x98>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a77970",
 				     "renesas,rcar-gen3-hscif",
-- 
2.11.0
