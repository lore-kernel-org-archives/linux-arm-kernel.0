From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 08:27:52 +0900
Subject: [PATCH v5 06/14] arm64: renesas: r8a7795: Sound CTU/MIX support
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1446161280-23097-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v5 [Simon Horman]
* Update for new CPG/MSSR bindings via Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 03690b12f44b..774bdf84709a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -375,6 +375,8 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
 				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
@@ -386,6 +388,8 @@
 				      "src.9", "src.8", "src.7", "src.6",
 				      "src.5", "src.4", "src.3", "src.2",
 				      "src.1", "src.0",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg>;
@@ -402,6 +406,22 @@
 				};
 			};
 
+			rcar_sound,mix {
+				mix0: mix at 0 { };
+				mix1: mix at 1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu at 0 { };
+				ctu01: ctu at 1 { };
+				ctu02: ctu at 2 { };
+				ctu03: ctu at 3 { };
+				ctu10: ctu at 4 { };
+				ctu11: ctu at 5 { };
+				ctu12: ctu at 6 { };
+				ctu13: ctu at 7 { };
+			};
+
 			rcar_sound,src {
 				src0: src at 0 {
 					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
