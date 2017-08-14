From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 14 Aug 2017 13:34:17 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: msm8996: add support to pcie
Message-ID: <20170814113420.30866-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to 3 pcie root complexes found on MSM8996.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 195 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      | 166 ++++++++++++++++++++++++
 2 files changed, 361 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 659940434842..c5c42e94f387 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -300,4 +300,199 @@
 			drive-strength = <2>;	/* 2 MA */
 		};
 	};
+
+	pcie0_clkreq_default: pcie0_clkreq_default {
+		mux {
+			pins = "gpio36";
+			function = "pci_e0";
+		};
+
+		config {
+			pins = "gpio36";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie0_perst_default: pcie0_perst_default {
+		mux {
+			pins = "gpio35";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio35";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie0_wake_default: pcie0_wake_default {
+		mux {
+			pins = "gpio37";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio37";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie0_clkreq_sleep: pcie0_clkreq_sleep {
+		mux {
+			pins = "gpio36";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio36";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie0_wake_sleep: pcie0_wake_sleep {
+		mux {
+			pins = "gpio37";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio37";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie1_clkreq_default: pcie1_clkreq_default {
+		mux {
+			pins = "gpio131";
+			function = "pci_e1";
+		};
+
+		config {
+			pins = "gpio131";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_perst_default: pcie1_perst_default {
+		mux {
+			pins = "gpio130";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio130";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie1_wake_default: pcie1_wake_default {
+		mux {
+			pins = "gpio132";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio132";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie1_clkreq_sleep: pcie1_clkreq_sleep {
+		mux {
+			pins = "gpio131";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio131";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie1_wake_sleep: pcie1_wake_sleep {
+		mux {
+			pins = "gpio132";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio132";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie2_clkreq_default: pcie2_clkreq_default {
+		mux {
+			pins = "gpio115";
+			function = "pci_e2";
+		};
+
+		config {
+			pins = "gpio115";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie2_perst_default: pcie2_perst_default {
+		mux {
+			pins = "gpio114";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio114";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie2_wake_default: pcie2_wake_default {
+		mux {
+			pins = "gpio116";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio116";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie2_clkreq_sleep: pcie2_clkreq_sleep {
+		mux {
+			pins = "gpio115";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio115";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie2_wake_sleep: pcie2_wake_sleep {
+		mux {
+			pins = "gpio116";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio116";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 887b61c872dd..d158fd16c440 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -819,6 +819,172 @@
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+		agnoc at 0 {
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+			compatible = "simple-pm-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pcie0: qcom,pcie at 00600000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				status = "disabled";
+				power-domains = <&gcc PCIE0_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				reg = <0x00600000 0x2000>,
+				      <0x0c000000 0xf1d>,
+				      <0x0c000f20 0xa8>,
+				      <0x0c100000 0x100000>;
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_0>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+
+				interrupts = <GIC_SPI 405 IRQ_TYPE_NONE>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie0_clkreq_default &pcie0_perst_default &pcie0_wake_default>;
+				pinctrl-1 = <&pcie0_clkreq_sleep &pcie0_perst_default &pcie0_wake_sleep>;
+
+
+				vdda-supply = <&pm8994_l28>;
+
+				linux,pci-domain = <0>;
+
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+					<&gcc GCC_PCIE_0_AUX_CLK>,
+					<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+
+			};
+
+			pcie1: qcom,pcie at 00608000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				power-domains = <&gcc PCIE1_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				status  = "disabled";
+
+				reg = <0x00608000 0x2000>,
+				      <0x0d000000 0xf1d>,
+				      <0x0d000f20 0xa8>,
+				      <0x0d100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_1>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+
+				interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
+				pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
+
+
+				vdda-supply = <&pm8994_l28>;
+				linux,pci-domain = <1>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+					<&gcc GCC_PCIE_1_AUX_CLK>,
+					<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie2: qcom,pcie at 00610000 {
+				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+				power-domains = <&gcc PCIE2_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+				status = "disabled";
+				reg = <0x00610000 0x2000>,
+				      <0x0e000000 0xf1d>,
+				      <0x0e000f20 0xa8>,
+				      <0x0e100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_2>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
+					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 421 IRQ_TYPE_NONE>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie2_clkreq_default &pcie2_perst_default &pcie2_wake_default>;
+				pinctrl-1 = <&pcie2_clkreq_sleep &pcie2_perst_default &pcie2_wake_sleep >;
+
+				vdda-supply = <&pm8994_l28>;
+
+				linux,pci-domain = <2>;
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
+					<&gcc GCC_PCIE_2_AUX_CLK>,
+					<&gcc GCC_PCIE_2_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
+
+				clock-names =  "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+		};
 	};
 
 	adsp-pil {
-- 
2.11.0
