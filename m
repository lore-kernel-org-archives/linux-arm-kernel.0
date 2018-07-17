From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Wed, 18 Jul 2018 04:48:01 +0900
Subject: [PATCH/RFT 5/7] arm64: dts: renesas: r8a77965: Add Sound DVC device
 nodes
In-Reply-To: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
References: <1531856883-19645-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <1531856883-19645-6-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Based on a similar patch of the R8A7796 device tree
by Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 91cb50f..61140e1 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1355,6 +1355,7 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
 				 <&cpg CPG_CORE R8A77965_CLK_S0D4>;
@@ -1365,6 +1366,7 @@
 				      "src.9", "src.8", "src.7", "src.6",
 				      "src.5", "src.4", "src.3", "src.2",
 				      "src.1", "src.0",
+				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 1005>,
@@ -1379,6 +1381,17 @@
 				      "ssi.1", "ssi.0";
 			status = "disabled";
 
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&audma1 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&audma1 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
 			rcar_sound,src {
 				src0: src-0 {
 					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
