From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:28 +0100
Subject: [PATCH 29/29] ARM: dts: r8a7794: remove Z clock
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <68cc085a4daaa32f7138de1e918331c05165a484.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

R8A7794 doesn't have Cortex-A15 CPUs, thus there's no Z clock...

Fixes: 0dce5454d5c2 ("ARM: shmobile: Initial r8a7794 SoC device tree")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 3 +--
 include/dt-bindings/clock/r8a7794-clock.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 44ce62938417..01816ac775a8 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1028,8 +1028,7 @@
 			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "z",
-					     "rcan";
+					     "lb", "qspi", "sdh", "sd0", "rcan";
 			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 9d02f5317c7c..88e64846cf37 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -20,8 +20,7 @@
 #define R8A7794_CLK_QSPI		5
 #define R8A7794_CLK_SDH			6
 #define R8A7794_CLK_SD0			7
-#define R8A7794_CLK_Z			8
-#define R8A7794_CLK_RCAN		9
+#define R8A7794_CLK_RCAN		8
 
 /* MSTP0 */
 #define R8A7794_CLK_MSIOF0		0
-- 
2.7.0.rc3.207.g0ac5344
