From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Dec 2014 09:54:36 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add USBDMAC[01] clocks to device tree
Message-ID: <1418000076-28780-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: merged per-clock patches]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Based on the renesas-devel-20141208-v3.18 tag of my renesas tree.
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7fd40f3..cad97512 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -493,13 +493,14 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&rclk_clk>;
+			clocks = <&rclk_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A7794_CLK_CMT1
+				R8A7794_CLK_CMT1 R8A7794_CLK_USBDMAC0
+				R8A7794_CLK_USBDMAC1
 			>;
 			clock-output-names =
-				"cmt1";
+				"cmt1", "usbdmac0", "usbdmac1";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 94e2bbf..52492d8 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -51,6 +51,8 @@
 
 /* MSTP3 */
 #define R8A7794_CLK_CMT1		29
+#define R8A7794_CLK_USBDMAC0		30
+#define R8A7794_CLK_USBDMAC1		31
 
 /* MSTP5 */
 #define R8A7794_CLK_THERMAL		22
-- 
2.1.3
