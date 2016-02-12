From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:16 +0100
Subject: [PATCH 26/68] ARM: dts: r8a7793: add DVC support to device tree
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <4dfc6f8bbf821850c7a4e7f1364a42b63375ad4e.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DVC support to sound node in r8a7793 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 8b1ec47754ac..3531d30fe107 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1127,17 +1127,23 @@
 			<&mstp10_clks R8A7793_CLK_SCU_SRC5>, <&mstp10_clks R8A7793_CLK_SCU_SRC4>,
 			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
+			<&mstp10_clks R8A7793_CLK_SCU_DVC0>, <&mstp10_clks R8A7793_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&cpg_clocks>;
 
 		status = "disabled";
 
+		rcar_sound,dvc {
+			dvc0: dvc at 0 { };
+			dvc1: dvc at 1 { };
+		};
 		rcar_sound,src {
 			src0: src at 0 { };
 			src1: src at 1 { };
-- 
2.7.0.rc3.207.g0ac5344
