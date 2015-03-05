From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:14 +0900
Subject: [PATCH 14/16] ARM: shmobile: r8a7778: add sound to DT
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <39a96792c5d351e002fadbdaaba5fc0c20450f1d.1425518338.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds an entry for an R-Car Gen. 1 sound controller.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[horms: Removed undocumented "renesas,rcar_sound" compat string]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 5d486b9..868f973 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -227,6 +227,61 @@
 		status = "disabled";
 	};
 
+	rcar_sound: sound at ffd90000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
+		reg =	<0xffd90000 0x1000>,	/* SRU */
+			<0xffd91000 0x1240>,	/* SSI */
+			<0xfffe0000 0x24>;	/* ADG */
+		clocks = <&mstp3_clks R8A7778_CLK_SSI8>,
+			<&mstp3_clks R8A7778_CLK_SSI7>,
+			<&mstp3_clks R8A7778_CLK_SSI6>,
+			<&mstp3_clks R8A7778_CLK_SSI5>,
+			<&mstp3_clks R8A7778_CLK_SSI4>,
+			<&mstp0_clks R8A7778_CLK_SSI3>,
+			<&mstp0_clks R8A7778_CLK_SSI2>,
+			<&mstp0_clks R8A7778_CLK_SSI1>,
+			<&mstp0_clks R8A7778_CLK_SSI0>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC8>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC7>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC6>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC5>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC4>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC3>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC2>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC1>,
+			<&mstp5_clks R8A7778_CLK_SRU_SRC0>,
+			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+			<&cpg_clocks R8A7778_CLK_S1>;
+		clock-names = "ssi.8", "ssi.7", "ssi.6", "ssi.5", "ssi.4",
+			"ssi.3", "ssi.2", "ssi.1", "ssi.0",
+			"src.8", "src.7", "src.6", "src.5", "src.4",
+			"src.3", "src.2", "src.1", "src.0",
+			"clk_a", "clk_b", "clk_c", "clk_i";
+
+		status = "disabled";
+
+		rcar_sound,src {
+			src3: src at 3 { };
+			src4: src at 4 { };
+			src5: src at 5 { };
+			src6: src at 6 { };
+			src7: src at 7 { };
+			src8: src at 8 { };
+			src9: src at 9 { };
+		};
+
+		rcar_sound,ssi {
+			ssi3: ssi at 3 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi4: ssi at 4 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi5: ssi at 5 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi6: ssi at 6 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi7: ssi at 7 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi8: ssi at 8 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi9: ssi at 9 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+		};
+	};
+
 	scif0: serial at ffe40000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-- 
2.1.4
