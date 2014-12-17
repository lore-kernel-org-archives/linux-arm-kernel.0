From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Dec 2014 09:45:56 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add DU clocks to device tree
Message-ID: <1418777156-25994-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
[horms: Resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

[Simon Horman]
Based on the renesas-devel-20141217-v3.18 tag of my renesas tree.
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 +++++--
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8f78da5..063bf56 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -535,7 +535,8 @@
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
@@ -543,11 +544,13 @@
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
 				R8A7794_CLK_SCIF0
+				R8A7794_CLK_DU1 R8A7794_CLK_DU0
 			>;
 			clock-output-names =
 				"ehci", "hsusb",
 				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0";
+				"scif3", "scif2", "scif1", "scif0",
+				"du1", "du0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index d633230..d5cfe62 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -76,6 +76,8 @@
 #define R8A7794_CLK_SCIF2		19
 #define R8A7794_CLK_SCIF1		20
 #define R8A7794_CLK_SCIF0		21
+#define R8A7794_CLK_DU1			23
+#define R8A7794_CLK_DU0			24
 
 /* MSTP8 */
 #define R8A7794_CLK_VIN1		10
-- 
2.1.3
