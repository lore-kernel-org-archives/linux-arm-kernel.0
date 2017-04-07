From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:12 -0400
Subject: [PATCH 11/22] ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <1cd9028027c7a7c10b774df698c3cfafec6aa67d.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The SSI-ALL gate clock is located in between the P clock and the
individual SSI[0-9] clocks, hence the former should be listed as their
parent.

Fixes: 072d326542e49187 ("ARM: dts: r8a7793: add MSTP10 clocks to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 9fcf3a9ca084..4de6041d61f9 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1269,8 +1269,11 @@
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
 			clocks = <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
 				<&p_clk>,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
 				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-- 
2.7.0.rc3.207.g0ac5344
