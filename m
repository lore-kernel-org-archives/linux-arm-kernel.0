From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Dec 2014 13:21:22 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Add IPMMU-SGX clock to device tree
Message-ID: <1418098882-5317-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[horms: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Based on the renesas-devel-20141209-v3.18 tag of my renesas tree

* Update by Simon Horman
  - Use SGX rather than GP in clock name to reflect datasheet
---
 arch/arm/boot/dts/r8a7791.dtsi            | 8 +++++---
 include/dt-bindings/clock/r8a7791-clock.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 958a69b..78d6371 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1154,15 +1154,17 @@
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
+				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
+				R8A7791_CLK_IPMMU_SGX
 				R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
 				R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
 			>;
 			clock-output-names =
-				"vin2", "vin1", "vin0", "ether", "sata1", "sata0";
+				"ipmmu_sgx", "vin2", "vin1", "vin0", "ether", "sata1",
+				"sata0";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 3ea2bbc..ee9bb944 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -91,6 +91,7 @@
 #define R8A7791_CLK_LVDS0		26
 
 /* MSTP8 */
+#define R8A7791_CLK_IPMMU_SGX		0
 #define R8A7791_CLK_VIN2		9
 #define R8A7791_CLK_VIN1		10
 #define R8A7791_CLK_VIN0		11
-- 
2.1.3
