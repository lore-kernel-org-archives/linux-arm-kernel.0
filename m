From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:09 +0100
Subject: [PATCH 02/31] ARM: dts: r8a7794: Correct hsusb parent clock
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <dc8ee9dbdba509fb58e23ba79f2e6059fe5d8b3b.1479931686.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The parent clock of the HSUSB clock is the HP clock, not the MP clock.

Fixes: c7bab9f929e51761 ("ARM: shmobile: r8a7794: Add USB clocks to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 01816ac775a8..7d9f0601d3ca 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1262,7 +1262,7 @@
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>,
+			clocks = <&mp_clk>, <&hp_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
 				 <&zx_clk>;
-- 
2.7.0.rc3.207.g0ac5344
