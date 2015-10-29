From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:27:51 +0900
Subject: [PATCH v5 05/14] arm64: renesas: r8a7795: Sound DVC support
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446161280-23097-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v5 [Simon Horman]
* Update for new CPG/MSSR bindings via Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 618989528b67..03690b12f44b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -375,6 +375,7 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
 				 <&cpg CPG_CORE R8A7795_CLK_S0D4>;
@@ -385,10 +386,22 @@
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
