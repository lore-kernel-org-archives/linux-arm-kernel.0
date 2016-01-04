From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:27:37 +1100
Subject: [PATCH v2 02/13] ARM: shmobile: r8a7793: add m2 clock to device tree
In-Reply-To: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
References: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1451946468-20499-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare m2 clock in r8a7793 device tree.

Based on similar work for the r8a7791 by Laurent Pinchart.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bf6be4a40e31..fa8a0d772d51 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -817,6 +817,14 @@
 			clock-mult = <1>;
 			clock-output-names = "p";
 		};
+		m2_clk: m2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "m2";
+		};
 		rclk_clk: rclk_clk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-- 
2.1.4
