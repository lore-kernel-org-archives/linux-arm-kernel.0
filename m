From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 10 Aug 2018 15:21:10 +0530
Subject: [PATCH v3 6/9] arm64: dts: actions: Add Reset Controller support for
 S900 SoC
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180810095113.25292-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset controller property and bindings header for the
Actions Semi S900 SoC DTS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..4fbb39fd7971 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 / {
 	compatible = "actions,s900";
@@ -172,6 +173,7 @@
 			reg = <0x0 0xe0160000 0x0 0x1000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		pinctrl: pinctrl at e01b0000 {
-- 
2.17.1
