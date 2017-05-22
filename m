From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:56 +0200
Subject: [PATCH 23/35] arm64: dts: r8a7796: add Sound DVC support
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <688d98138bd00e3c8cb0a6044856449449d0d9e7.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 778275a980d3..156c0f8a81ba 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1196,6 +1196,7 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
 				 <&cpg CPG_CORE R8A7796_CLK_S0D4>;
@@ -1206,15 +1207,19 @@
 				      "src.9", "src.8", "src.7", "src.6",
 				      "src.5", "src.4", "src.3", "src.2",
 				      "src.1", "src.0",
+				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			rcar_sound,dvc {
 				dvc0: dvc-0 {
+					dmas = <&audma1 0xbc>;
+					dma-names = "tx";
 				};
-
 				dvc1: dvc-1 {
+					dmas = <&audma1 0xbe>;
+					dma-names = "tx";
 				};
 			};
 
-- 
2.1.4
