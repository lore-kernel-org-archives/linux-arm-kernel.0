From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:11 +0530
Subject: [PATCH v2 06/10] arm64: dts: actions: Add RMU node for Actions Semi
 S900 SoC
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Controller Unit (RMU) node under the system-controller node
for Actions Semi S900 SoC. Also add the bindings constant header to
be used by clients.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index d239033f9599..a242d3193a6a 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/actions,s900-rmu.h>
 
 / {
 	compatible = "actions,s900";
@@ -176,6 +177,11 @@
 				clocks = <&hosc>, <&losc>;
 				#clock-cells = <1>;
 			};
+
+			rmu: reset-controller {
+				compatible = "actions,s900-rmu";
+				#reset-cells = <1>;
+			};
 		};
 
 		pinctrl: pinctrl at e01b0000 {
-- 
2.17.1
