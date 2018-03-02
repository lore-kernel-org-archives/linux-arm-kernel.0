From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri,  2 Mar 2018 09:20:41 +0530
Subject: [PATCH v4 06/10] arm64: dts: actions: Add S900 gpio nodes
In-Reply-To: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180302035045.14660-7-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts |  6 +++
 arch/arm64/boot/dts/actions/s900.dtsi             | 48 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index ff043c961d75..60ddaf98401b 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -14,6 +14,12 @@
 
 	aliases {
 		serial5 = &uart5;
+		gpio0 = &gpioa;
+		gpio1 = &gpiob;
+		gpio2 = &gpioc;
+		gpio3 = &gpiod;
+		gpio4 = &gpioe;
+		gpio5 = &gpiof;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..9c7843045850 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -180,6 +180,54 @@
 			clocks = <&cmu CLK_GPIO>;
 		};
 
+		gpioa: gpioa at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+		};
+
+		gpiob: gpiob at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+		};
+
+		gpioc: gpioc at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 12>;
+		};
+
+		gpiod: gpiod at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 76 30>;
+		};
+
+		gpioe: gpioe at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 106 32>;
+		};
+
+		gpiof: gpiof at e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 138 8>;
+		};
+
 		timer: timer at e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
