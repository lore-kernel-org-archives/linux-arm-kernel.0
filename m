From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed,  6 Sep 2017 14:52:06 +0100
Subject: [PATCH v3] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <1502704398-28378-1-git-send-email-biju.das@bp.renesas.com>
References: <1502704398-28378-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504705926-31625-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
v2->v3
- Renamed lables to use iic instead of i2c.

v1->v2
- Corrected the resets property for i2c6 device node.

This patch is based on renesas-devel tag renesas-devel-20170905-v4.13.

DT bindings has been accepted by Wolfram:
https://patchwork.kernel.org/patch/9888119


 arch/arm/boot/dts/r8a7743.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 665a515..266c5ec 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -25,6 +25,9 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		i2c6 = &iic0;
+		i2c7 = &iic1;
+		i2c8 = &iic3;
 	};
 
 	cpus {
@@ -436,6 +439,58 @@
 			status = "disabled";
 		};
 
+		iic0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
+			status = "disabled";
+		};
+
+		iic1: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 323>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 323>;
+			status = "disabled";
+		};
+
+		iic3: i2c at e60b0000 {
+			/* doesn't need pinmux */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
+			       <&dmac1 0x77>, <&dmac1 0x78>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 926>;
+			status = "disabled";
+		};
+
 		scifa0: serial at e6c40000 {
 			compatible = "renesas,scifa-r8a7743",
 				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
1.9.1
