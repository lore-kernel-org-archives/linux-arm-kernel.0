From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Aug 2017 09:28:20 +0200
Subject: [PATCH] ARM: dts: augment Ux500 to use DT cpufreq
Message-ID: <20170822072820.15801-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the operating points to the Ux500 device tree and
deletes the old special-purpose cpufreq node, as we can now
use the generic DT cpufreq driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for v4.14, I have
no other ux500 DTS patches coming this merge window as far
as I know. It is just using standard bindings.
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 6c5affe2d0f5..2310a4e97768 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -37,6 +37,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x300>;
+			/* cpufreq controls */
+			operating-points = <998400 0
+					    800000 0
+					    400000 0
+					    200000 0>;
+			clocks = <&prcmu_clk PRCMU_ARMSS>;
+			clock-names = "cpu";
+			clock-latency = <20000>;
 		};
 		CPU1: cpu at 301 {
 			device_type = "cpu";
@@ -494,13 +502,6 @@
 				reg = <0x80157450 0xC>;
 			};
 
-			cpufreq {
-				compatible = "stericsson,cpufreq-ux500";
-				clocks = <&prcmu_clk PRCMU_ARMSS>;
-				clock-names = "armss";
-				status = "disabled";
-			};
-
 			thermal at 801573c0 {
 				compatible = "stericsson,db8500-thermal";
 				reg = <0x801573c0 0x40>;
-- 
2.13.5
