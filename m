From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:30 +0900
Subject: [PATCH 9/9] ARM: shmobile: r8a7791: Add Audio MIX support on DTSI
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <7fd6e11dca09b21efbe2b9db4eff08c8f4a16125.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index cdd55b82ba4e..d37339bd7cdb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1586,6 +1586,7 @@
 			<&mstp10_clks R8A7791_CLK_SCU_SRC3>, <&mstp10_clks R8A7791_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC1>, <&mstp10_clks R8A7791_CLK_SCU_SRC0>,
 			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
+			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7791_CLK_SCU_DVC0>, <&mstp10_clks R8A7791_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1594,6 +1595,7 @@
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"ctu.0", "ctu.1",
+				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
@@ -1610,6 +1612,11 @@
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
