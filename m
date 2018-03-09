From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri,  9 Mar 2018 10:43:41 +0530
Subject: [PATCH v5 5/9] arm64: dts: actions: Add S900 gpio nodes
In-Reply-To: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180309051345.1011-6-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..69ead8a24b6b 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -180,6 +180,60 @@
 			clocks = <&cmu CLK_GPIO>;
 		};
 
+		gpioa: gpio at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			ngpios = <32>;
+		};
+
+		gpiob: gpio at e01b000c {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b000c 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			ngpios = <32>;
+		};
+
+		gpioc: gpio at e01b0018 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0018 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 12>;
+			ngpios = <12>;
+		};
+
+		gpiod: gpio at e01b0024 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0024 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 76 30>;
+			ngpios = <30>;
+		};
+
+		gpioe: gpio at e01b0030 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0030 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 106 32>;
+			ngpios = <32>;
+		};
+
+		gpiof: gpio at e01b00f0 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b00f0 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 138 8>;
+			ngpios = <8>;
+		};
+
 		timer: timer at e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
