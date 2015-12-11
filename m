From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:56 +0900
Subject: [PATCH/RFC 19/19] ARM: shmobile: r8a7793: add Audio MIX support to
 device tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1449802376-11301-20-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate audio MIX support in r8a7793 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index d9ba1c97cefc..a5054d49cd5b 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1179,6 +1179,7 @@
 			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
 			<&mstp10_clks R8A7793_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7793_CLK_SCU_CTU1_MIX1>,
+			<&mstp10_clks R8A7793_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7793_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7793_CLK_SCU_DVC0>, <&mstp10_clks R8A7793_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1187,6 +1188,7 @@
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"ctu.0", "ctu.1",
+				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&cpg_clocks>;
@@ -1204,6 +1206,11 @@
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
