From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 17:12:31 +0200
Subject: [PATCH] ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions
Message-ID: <20180828151231.16177-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the hardcoded clock indices by R9A06G032_CLK_* symbols.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index afe29c95a006e8fa..3e45375b79aa9c0d 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a06g032-sysctrl.h>
 
 / {
 	compatible = "renesas,r9a06g032";
@@ -21,14 +22,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0>;
-			clocks = <&sysctrl 84>;
+			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <1>;
-			clocks = <&sysctrl 84>;
+			clocks = <&sysctrl R9A06G032_CLK_A7MP>;
 			enable-method = "renesas,r9a06g032-smp";
 			cpu-release-addr = <0 0x4000c204>;
 		};
@@ -82,7 +83,7 @@
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&sysctrl 146>;
+			clocks = <&sysctrl R9A06G032_CLK_UART0>;
 			clock-names = "baudclk";
 			status = "disabled";
 		};
-- 
2.17.1
