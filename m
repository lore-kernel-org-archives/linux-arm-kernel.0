From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 24 Oct 2018 00:36:51 +0530
Subject: [PATCH 1/5] arm64: dts: hisilicon: Add Pinctrl support for HiKey970
 board
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181023190655.12004-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl support based on "pinctrl-single" driver for HiKey970
development board from HiSilicon.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
new file mode 100644
index 000000000000..64fb9a3bd707
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl dts file for HiSilicon HiKey970 development board
+ */
+
+#include <dt-bindings/pinctrl/hisi.h>
+
+/ {
+	soc {
+		range: gpio-range {
+			#pinctrl-single,gpio-range-cells = <3>;
+		};
+
+		pmx0: pinmux at e896c000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xe896c000 0x0 0x72c>;
+			#pinctrl-cells = <1>;
+			#gpio-range-cells = <0x3>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 82 0>;
+		};
+
+		pmx2: pinmux at e896c800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xe896c800 0x0 0x72c>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx5: pinmux at fc182000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xfc182000 0x0 0x028>;
+			#gpio-range-cells = <3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 10 0>;
+
+		};
+
+		pmx6: pinmux at fc182800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xfc182800 0x0 0x028>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx7: pinmux at ff37e000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xff37e000 0x0 0x030>;
+			#gpio-range-cells = <3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 12 0>;
+		};
+
+		pmx8: pinmux at ff37e800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xff37e800 0x0 0x030>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+
+		pmx1: pinmux at fff11000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xfff11000 0x0 0x73c>;
+			#gpio-range-cells = <0x3>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+			pinctrl-single,function-mask = <0x7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 46 0>;
+		};
+
+		pmx16: pinmux at fff11800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xfff11800 0x0 0x73c>;
+			#pinctrl-cells = <1>;
+			pinctrl-single,register-width = <0x20>;
+		};
+	};
+};
-- 
2.17.1
