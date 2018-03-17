From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 17 Mar 2018 15:39:42 +0530
Subject: [PATCH v5 02/12] arm64: dts: actions: Add S900 clock management unit
 nodes
In-Reply-To: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180317100952.28538-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Actions Semi S900 Clock Management Unit (CMU) nodes

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 11406f6d3a6d..fee0c9557656 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -4,6 +4,7 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/clock/actions,s900-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -88,6 +89,18 @@
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
+	diff24M: diff24M {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -154,6 +167,13 @@
 			status = "disabled";
 		};
 
+		cmu: clock-controller at e0160000 {
+			compatible = "actions,s900-cmu";
+			reg = <0x0 0xe0160000 0x0 0x1000>;
+			clocks = <&hosc>, <&losc>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer at e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
