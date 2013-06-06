From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:13:17 +0100
Subject: [PATCH 01/32] ARM: ux500: Add PRCMU clock node to DBx500 Device Tree
Message-ID: <1370520828-31165-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index a082f0b..a635f7f 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/dbx500-prcmu.h>
 #include "skeleton.dtsi"
 
 / {
@@ -42,6 +43,14 @@
 			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		clocks {
+			compatible = "stericsson,u8500-clks";
+
+			prcmu_clk: prcmu-clock {
+				#clock-cells = <1>;
+			};
+		};
+
 		timer at a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
-- 
1.7.10.4
