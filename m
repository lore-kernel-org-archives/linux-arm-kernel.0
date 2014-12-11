From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Dec 2014 09:59:21 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add QSPI clock to device tree
Message-ID: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[horms: omitted device node and alias; only add clock]
Signed-off-by: Simon Horman <horms+renesas@verge.net.a, not device nodes:u>

---
Based on the renesas-devel-20141211-v3.18 tag of my renesas tree

Changes by Simon Horman
* Removed portions of patch which add device node and alias
* Renamed patch from
  "ARM: shmobile: r8a7794: Add QSPI clock and device to device tree" to
  "ARM: shmobile: r8a7794: Add QSPI clock to device tree"
---
 arch/arm/boot/dts/r8a7794.dtsi            | 8 ++++++++
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6d95638..9f59849 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -535,6 +535,14 @@
 			clock-output-names =
 				"vin1", "vin0", "ether";
 		};
+		mstp9_clks: mstp9_clks at e6150994 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&cpg_clocks R8A7794_CLK_QSPI>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7794_CLK_QSPI_MOD>;
+			clock-output-names = "qspi_mod";
+		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index c0bd14a5..fba89a4 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -86,6 +86,7 @@
 #define R8A7794_CLK_GPIO2		10
 #define R8A7794_CLK_GPIO1		11
 #define R8A7794_CLK_GPIO0		12
+#define R8A7794_CLK_QSPI_MOD		17
 
 /* MSTP11 */
 #define R8A7794_CLK_SCIFA3		6
-- 
2.1.3
