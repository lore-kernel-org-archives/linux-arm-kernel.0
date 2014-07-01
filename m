From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:21 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: add DVC support for sound node on
 DTSI
In-Reply-To: <cover.1404174433.git.horms+renesas@verge.net.au>
References: <cover.1404174433.git.horms+renesas@verge.net.au>
Message-ID: <150c8ad40808189423002ea9fc6a858a3a59e6dc.1404174433.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1997f16..336a6c0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1005,16 +1005,23 @@
 			<&mstp10_clks R8A7791_CLK_SCU_SRC5>, <&mstp10_clks R8A7791_CLK_SCU_SRC4>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC3>, <&mstp10_clks R8A7791_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC1>, <&mstp10_clks R8A7791_CLK_SCU_SRC0>,
+			<&mstp10_clks R8A7791_CLK_SCU_DVC0>, <&mstp10_clks R8A7791_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
 		status = "disabled";
 
+		rcar_sound,dvc {
+			dvc0: dvc at 0 { };
+			dvc1: dvc at 1 { };
+		};
+
 		rcar_sound,src {
 			src0: src at 0 { };
 			src1: src at 1 { };
-- 
2.0.0.rc2
