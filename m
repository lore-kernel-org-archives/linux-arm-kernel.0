From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 28 Feb 2018 18:47:04 +0800
Subject: [RESEND PATCH 1/7] arm64: dts: Add hwspinlock node for Spreadtrum
 SC9860
Message-ID: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Spreadtrum SC9860 platform only has one hardware spinlock device,
which is located on AON system of Spreadtrum SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 328009c..b9cc0fb 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -6,6 +6,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/clock/sprd,sc9860-clk.h>
+
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
@@ -104,6 +106,21 @@
 				status = "disabled";
 			};
 		};
+
+		aon {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			hwlock: hwspinlock at 40500000 {
+				compatible = "sprd,hwspinlock-r3p0";
+				reg = <0 0x40500000 0 0x1000>;
+				#hwlock-cells = <1>;
+				clock-names = "enable";
+				clocks = <&aon_gate CLK_SPLK_EB>;
+			};
+		};
 	};
 
 	ext_32k: ext_32k {
-- 
1.7.9.5
