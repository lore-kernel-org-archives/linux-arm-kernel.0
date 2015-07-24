From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:28 +0900
Subject: [PATCH 7/9] ARM: shmobile: r8a7790: Add Audio MIX support on DTSI
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <fc67bf42fa9a3e7c891e6318475f9c4d81a1d44e.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6aa1d759690b..f1cdccc0a8c8 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1540,6 +1540,7 @@
 			<&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
 			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
+			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7790_CLK_SCU_DVC0>, <&mstp10_clks R8A7790_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1548,6 +1549,7 @@
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"ctu.0", "ctu.1",
+				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
@@ -1564,6 +1566,11 @@
 			};
 		};
 
+		rcar_sound,mix {
+			mix0: mix at 0 { };
+			mix1: mix at 1 { };
+		};
+
 		rcar_sound,ctu {
 			ctu00: ctu at 0 { };
 			ctu01: ctu at 1 { };
-- 
2.1.4
