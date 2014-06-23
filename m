From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:28 +0900
Subject: [PATCH 19/29] ARM: shmobile: r8a7791: add audio clock on DTSI
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <0d3dbde84a45977cdd7d85115cd5ea1b4ede312e.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

audio_clk_a/b/c are required from sound driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b639006..f3b6219 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -532,6 +532,29 @@
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
 			compatible = "renesas,r8a7791-cpg-clocks",
-- 
2.0.0.rc2
