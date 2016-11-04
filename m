From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:00 +0100
Subject: [PATCH 01/29] ARM: dts: r7s72100: add mmcif clock to device tree
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <6c35a666566cf48faaa95699b0d79c6b8cad824c.1478252308.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r7s72100-clock.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index fb9ef9ca120e..e18d4e645d6e 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -117,6 +117,15 @@
 			clock-output-names = "ether";
 		};
 
+		mstp8_clks: mstp8_clks at fcfe0434 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0434 4>;
+			clocks = <&p1_clk>;
+			clock-indices = <R7S72100_CLK_MMCIF>;
+			clock-output-names = "mmcif";
+		};
+
 		mstp9_clks: mstp9_clks at fcfe0438 {
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 3cd813896d08..5eaf0fb469c2 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -28,6 +28,9 @@
 /* MSTP7 */
 #define R7S72100_CLK_ETHER	4
 
+/* MSTP8 */
+#define R7S72100_CLK_MMCIF	4
+
 /* MSTP9 */
 #define R7S72100_CLK_I2C0	7
 #define R7S72100_CLK_I2C1	6
-- 
2.7.0.rc3.207.g0ac5344
