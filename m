From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:20 +0200
Subject: [PATCH 10/14] ARM: dts: r7s72100: add usb clocks to device tree
In-Reply-To: <cover.1495455272.git.horms+renesas@verge.net.au>
References: <cover.1495455272.git.horms+renesas@verge.net.au>
Message-ID: <9907a4a00f6df0796d6e838c9dbf3ecce2ec4600.1495455272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

This adds the USB0 and USB1 clocks to the device tree.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 0423996e4dcc..5cf53e9943af 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -144,9 +144,9 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0430 4>;
-			clocks = <&b_clk>;
-			clock-indices = <R7S72100_CLK_ETHER>;
-			clock-output-names = "ether";
+			clocks = <&b_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <R7S72100_CLK_ETHER R7S72100_CLK_USB0 R7S72100_CLK_USB1>;
+			clock-output-names = "ether", "usb0", "usb1";
 		};
 
 		mstp8_clks: mstp8_clks at fcfe0434 {
-- 
2.1.4
