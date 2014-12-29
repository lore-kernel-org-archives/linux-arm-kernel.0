From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:38 +0900
Subject: [PATCH 07/30] ARM: shmobile: r8a7794: Add USB clocks to device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <c7bab9f929e5176169de2cee529ec203ca7f1584.1419812185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
[horms: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 5 ++++-
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 1801bb4..7fd40f3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -504,16 +504,19 @@
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
+			clocks = <&mp_clk>, <&mp_clk>,
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
+				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
 				R8A7794_CLK_SCIF0
 			>;
 			clock-output-names =
+				"ehci", "hsusb",
 				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
 				"scif3", "scif2", "scif1", "scif0";
 		};
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index aa9c286..94e2bbf 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -57,6 +57,8 @@
 #define R8A7794_CLK_PWM			23
 
 /* MSTP7 */
+#define R8A7794_CLK_EHCI		3
+#define R8A7794_CLK_HSUSB		4
 #define R8A7794_CLK_HSCIF2		13
 #define R8A7794_CLK_SCIF5		14
 #define R8A7794_CLK_SCIF4		15
-- 
2.1.3
