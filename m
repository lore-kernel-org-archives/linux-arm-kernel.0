From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 18 Feb 2018 02:14:29 +0530
Subject: [PATCH 06/10] arm64: dts: actions: Add S900 gpio nodes
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180217204433.3095-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..e359509ad9d3 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -180,6 +180,13 @@
 			clocks = <&cmu CLK_GPIO>;
 		};
 
+		gpio: gpio at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		timer: timer at e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
