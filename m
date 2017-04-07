From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:11 -0400
Subject: [PATCH 10/22] ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <16fe68dcab5702a024d85229ff7e98979cb701a5.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: ee9141522dcf13f8 ("ARM: shmobile: r8a7791: add MSTP10 support on DTSI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b319ef4d57b0..a6478ca3f4ca 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1447,8 +1447,11 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7791_CLK_SSI_ALL>, <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-- 
2.7.0.rc3.207.g0ac5344
