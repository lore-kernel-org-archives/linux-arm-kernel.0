From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 28 Jul 2018 00:15:23 +0530
Subject: [PATCH 5/9] arm64: dts: actions: Add Reset Controller support for
 S700 SoC
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180727184527.13287-6-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset controller property and bindings header for the
Actions Semi S700 SoC DTS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..db4c544d5311 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 / {
 	compatible = "actions,s700";
@@ -165,6 +166,7 @@
 			reg = <0x0 0xe0168000 0x0 0x1000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		sps: power-controller at e01b0100 {
-- 
2.17.1
