From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 10 Dec 2014 10:21:12 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add SYS-DMAC clocks to device tree
Message-ID: <1418174472-1034-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
[horms: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Based on the renesas-devel-20141210-v3.18 tag of my renesas tree.
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 +++++--
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 13e4a8d..6d95638 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -479,16 +479,19 @@
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7794_CLK_SCIFA2 R8A7794_CLK_SCIFA1 R8A7794_CLK_SCIFA0
 				R8A7794_CLK_MSIOF2 R8A7794_CLK_SCIFB0 R8A7794_CLK_SCIFB1
 				R8A7794_CLK_MSIOF1 R8A7794_CLK_SCIFB2
+				R8A7794_CLK_SYS_DMAC1 R8A7794_CLK_SYS_DMAC0
 			>;
 			clock-output-names =
 				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "scifb2";
+				"scifb1", "msiof1", "scifb2",
+				"sys-dmac1", "sys-dmac0";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 52492d8..c0bd14a5 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -48,6 +48,8 @@
 #define R8A7794_CLK_SCIFB1		7
 #define R8A7794_CLK_MSIOF1		8
 #define R8A7794_CLK_SCIFB2		16
+#define R8A7794_CLK_SYS_DMAC1		18
+#define R8A7794_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
 #define R8A7794_CLK_CMT1		29
-- 
2.1.3
