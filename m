From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:30 +0900
Subject: [PATCH 13/18] arm64: renesas: r8a7795: Sound DVC support
In-Reply-To: <cover.1448587800.git.horms+renesas@verge.net.au>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
Message-ID: <b9dd9450ce0cfb60d8e4afd37191f86f3afba6c2.1448587800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c3b2089de531..b1902ea1dae4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -590,6 +590,7 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
 				 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
@@ -600,10 +601,22 @@
 				      "src.9", "src.8", "src.7", "src.6",
 				      "src.5", "src.4", "src.3", "src.2",
 				      "src.1", "src.0",
+				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg>;
 			status = "disabled";
 
+			rcar_sound,dvc {
+				dvc0: dvc at 0 {
+					dmas = <&audma0 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc at 1 {
+					dmas = <&audma0 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
 			rcar_sound,src {
 				src0: src at 0 {
 					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
