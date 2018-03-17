From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 17 Mar 2018 15:39:43 +0530
Subject: [PATCH v5 03/12] arm64: dts: actions: Source CMU clock for UART5
In-Reply-To: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180317100952.28538-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove fixed clock and source CMU (Clock Management Unit) clock for
UART5 driver in Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 21ca80f9941c..ff043c961d75 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -24,12 +24,6 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-
-	uart5_clk: uart5-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -38,5 +32,5 @@
 
 &uart5 {
 	status = "okay";
-	clocks = <&uart5_clk>;
+	clocks = <&cmu CLK_UART5>;
 };
-- 
2.14.1
