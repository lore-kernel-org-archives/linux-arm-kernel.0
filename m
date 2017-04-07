From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:09 -0400
Subject: [PATCH 08/22] ARM: dts: r7s72100: fix ethernet clock parent
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <91a7c50cb4fabfba218549dfa84356069918bfbf.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Technically, the Ethernet block is run off the 133MHz Bus (B) clock, not
the 33MHz Peripheral 0 (P0) clock.

Fixes: 969244f9c720 ("ARM: dts: r7s72100: add ethernet clock to device tree")
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 9fb2e510958a..47ef53a4c8bf 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -121,7 +121,7 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0430 4>;
-			clocks = <&p0_clk>;
+			clocks = <&b_clk>;
 			clock-indices = <R7S72100_CLK_ETHER>;
 			clock-output-names = "ether";
 		};
-- 
2.7.0.rc3.207.g0ac5344
