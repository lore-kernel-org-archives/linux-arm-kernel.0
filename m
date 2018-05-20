From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 20 May 2018 10:47:33 +0530
Subject: [PATCH v2 2/5] arm64: dts: actions: Add gpio properties to pinctrl
 node for S900
In-Reply-To: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180520051736.4842-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio properties to pinctrl node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..aa3a49b0d646 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -178,6 +178,9 @@
 			compatible = "actions,s900-pinctrl";
 			reg = <0x0 0xe01b0000 0x0 0x1000>;
 			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 146>;
+			#gpio-cells = <2>;
 		};
 
 		timer: timer at e0228000 {
-- 
2.14.1
