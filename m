From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Mar 2017 12:45:30 +0200
Subject: [PATCH 1/4] ARM: dts: r8a7794: Add DU1 clock to device tree
In-Reply-To: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
References: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490697933-5849-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing module clock for the second channel of the display unit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 8 +++++---
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 38bf9ed8e739ea2b..f5f8d1c03ef7c3a3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1270,19 +1270,21 @@
 			clocks = <&mp_clk>, <&hp_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&zx_clk>;
+				 <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
-				R8A7794_CLK_SCIF0 R8A7794_CLK_DU0
+				R8A7794_CLK_SCIF0
+				R8A7794_CLK_DU1 R8A7794_CLK_DU0
 			>;
 			clock-output-names =
 				"ehci", "hsusb",
 				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0", "du0";
+				"scif3", "scif2", "scif1", "scif0",
+				"du1", "du0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index a26776f7deddbaa4..93e99c3ffc8dafeb 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -82,6 +82,7 @@
 #define R8A7794_CLK_SCIF2		19
 #define R8A7794_CLK_SCIF1		20
 #define R8A7794_CLK_SCIF0		21
+#define R8A7794_CLK_DU1			23
 #define R8A7794_CLK_DU0			24
 
 /* MSTP8 */
-- 
2.7.4
