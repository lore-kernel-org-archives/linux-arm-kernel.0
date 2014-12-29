From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:51 +0900
Subject: [PATCH 20/30] ARM: shmobile: r8a7794: Add I2C clocks to device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <c5d82c9996f68491375de47c208a41bcb150dfad.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
[horms: omitted device nodes and aliases; only add clocks]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 12 +++++++++---
 include/dt-bindings/clock/r8a7794-clock.h |  6 ++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 068ca09..728d719 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -538,10 +538,16 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cpg_clocks R8A7794_CLK_QSPI>;
+			clocks = <&cpg_clocks R8A7794_CLK_QSPI>, <&hp_clk>, <&hp_clk>,
+				<&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_QSPI_MOD>;
-			clock-output-names = "qspi_mod";
+			clock-indices = <
+				R8A7794_CLK_QSPI_MOD R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
+				R8A7794_CLK_I2C3 R8A7794_CLK_I2C2 R8A7794_CLK_I2C1
+				R8A7794_CLK_I2C0
+			>;
+			clock-output-names =
+				"qspi_mod", "i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index fba89a4..94d9618 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -87,6 +87,12 @@
 #define R8A7794_CLK_GPIO1		11
 #define R8A7794_CLK_GPIO0		12
 #define R8A7794_CLK_QSPI_MOD		17
+#define R8A7794_CLK_I2C5		25
+#define R8A7794_CLK_I2C4		27
+#define R8A7794_CLK_I2C3		28
+#define R8A7794_CLK_I2C2		29
+#define R8A7794_CLK_I2C1		30
+#define R8A7794_CLK_I2C0		31
 
 /* MSTP11 */
 #define R8A7794_CLK_SCIFA3		6
-- 
2.1.3
