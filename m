From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:47 +0900
Subject: [PATCH 16/30] ARM: shmobile: r8a7794: Add QSPI clock to device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <3281480b70ceb9889b71f7b8a7bf54db3c05d40e.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[horms: omitted device node and alias; only add clock]
[horms: use clock-indicies instead of renesas,clock-indicies]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 8 ++++++++
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6d95638..068ca09 100644
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
+			clock-indices = <R8A7794_CLK_QSPI_MOD>;
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
