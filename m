From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:57 +0200
Subject: [PATCH 095/102] arm64: dts: renesas: r8a77965: add I2C support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <111d3ffe1692af078609516b407e494ac985684b.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 99 ++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index f51c1b2cbae4..1f67aea49305 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -20,6 +20,13 @@
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
 		i2c7 = &i2c_dvfs;
 	};
 
@@ -314,44 +321,118 @@
 		};
 
 		i2c0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe6500000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
+			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
+			       <&dmac2 0x91>, <&dmac2 0x90>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
 		i2c1: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe6508000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
+			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
+			       <&dmac2 0x93>, <&dmac2 0x92>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
 		i2c2: i2c at e6510000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe6510000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
+			       <&dmac2 0x95>, <&dmac2 0x94>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
 		i2c3: i2c at e66d0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe66d0000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
 		i2c4: i2c at e66d8000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe66d8000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
 		i2c5: i2c at e66e0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe66e0000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 919>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
+			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
 		i2c6: i2c at e66e8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77965",
+				     "renesas,rcar-gen3-i2c";
 			reg = <0 0xe66e8000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 918>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 918>;
+			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
 		i2c_dvfs: i2c at e60b0000 {
-- 
2.11.0
