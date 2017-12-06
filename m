From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:36 +0100
Subject: [PATCH 41/61] ARM: dts: r8a7743: add VIN dt support
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <001b32ae64dbf780d89fbc258c3f1007ee7b34e8.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add VIN[012] support to SoC dt. Also, add aliases.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 9e26c40976ff..c09c6672ca37 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -32,6 +32,9 @@
 		spi1 = &msiof0;
 		spi2 = &msiof1;
 		spi3 = &msiof2;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
 	};
 
 	cpus {
@@ -1037,6 +1040,39 @@
 			};
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			status = "disabled";
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			status = "disabled";
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			status = "disabled";
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7743";
 			reg = <0 0xfeb00000 0 0x40000>,
-- 
2.11.0
