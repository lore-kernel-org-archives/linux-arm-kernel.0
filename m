From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:21 +0100
Subject: [PATCH 27/70] ARM: dts: r8a7793: add audio DMAC clocks to device tree
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <8d2883bddf47e3d59a4f041c6bd338f0d18783fe.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate Audio DMA clocks in the r8a7791 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 3531d30fe107..cb6251e71ef9 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -924,10 +924,11 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&extal_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_THERMAL>;
-			clock-output-names = "thermal";
+			clock-indices = <R8A7793_CLK_AUDIO_DMAC0 R8A7793_CLK_AUDIO_DMAC1
+					 R8A7793_CLK_THERMAL>;
+			clock-output-names = "audmac0", "audmac1", "thermal";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7793-mstp-clocks",
-- 
2.7.0.rc3.207.g0ac5344
