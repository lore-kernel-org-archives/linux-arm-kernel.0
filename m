From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:26 -0800
Subject: [PATCH 19/29] ARM: shmobile: r8a7794: Add DU0 clock
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <9859cd3b1582cbe39f969a500d8b7fc87c4b87b8.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU0 clock is an MSTP clock, child of the CPG ZX clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 018ff56470b6..b70e4061d8b1 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1017,19 +1017,20 @@
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&zx_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
-				R8A7794_CLK_SCIF0
+				R8A7794_CLK_SCIF0 R8A7794_CLK_DU0
 			>;
 			clock-output-names =
 				"ehci", "hsusb",
 				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0";
+				"scif3", "scif2", "scif1", "scif0", "du0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 09da38a58776..a7a7e0370968 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -79,6 +79,7 @@
 #define R8A7794_CLK_SCIF2		19
 #define R8A7794_CLK_SCIF1		20
 #define R8A7794_CLK_SCIF0		21
+#define R8A7794_CLK_DU0			24
 
 /* MSTP8 */
 #define R8A7794_CLK_VIN1		10
-- 
2.1.4
