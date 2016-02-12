From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:13 +0100
Subject: [PATCH 23/68] ARM: dts: r8a7793: add audio clock to device tree
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <ad6472bf11464d498fefcea9ae30ddf9255e4f49.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate audio clock in r8a7793 device tree.
audio_clk_a/b/c are required for R-Car sound.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index c4459f147330..530fa9488a4a 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -706,6 +706,29 @@
 			clock-output-names = "extal";
 		};
 
+		/*
+		 * The external audio clocks are configured as 0 Hz fixed frequency clocks by
+		 * default. Boards that provide audio clocks should override them.
+		 */
+		audio_clk_a: audio_clk_a {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_a";
+		};
+		audio_clk_b: audio_clk_b {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_b";
+		};
+		audio_clk_c: audio_clk_c {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_c";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7793-cpg-clocks",
-- 
2.7.0.rc3.207.g0ac5344
