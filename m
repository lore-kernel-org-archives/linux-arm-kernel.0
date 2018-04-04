From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  4 Apr 2018 22:52:50 +0530
Subject: [PATCH v7 1/9] arm64: dts: actions: Add pinctrl node for S900
In-Reply-To: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180404172258.7678-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes for Actions Semi S900 SoC

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index fee0c9557656..0156483f0f4d 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -174,6 +174,12 @@
 			#clock-cells = <1>;
 		};
 
+		pinctrl: pinctrl at e01b0000 {
+			compatible = "actions,s900-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+		};
+
 		timer: timer at e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
