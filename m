From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 17 Mar 2015 12:48:33 +0200
Subject: [PATCH v2 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
In-Reply-To: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
References: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1426589315-16847-2-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPMI PMIC Arbiter configuration nodes for APQ8084 and MSM8974.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Reviewed-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 1f130bc..dbedf64 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -226,5 +226,21 @@
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
+
+		spmi_bus: spmi at fc4cf000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg-names = "core", "intr", "cnfg";
+			reg = <0xfc4cf000 0x1000>,
+			      <0xfc4cb000 0x1000>,
+			      <0xfc4ca000 0x1000>;
+			interrupt-names = "periph_irq";
+			interrupts = <0 190 0>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e265ec1..2d11641 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -247,5 +247,21 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		spmi_bus: spmi at fc4cf000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg-names = "core", "intr", "cnfg";
+			reg = <0xfc4cf000 0x1000>,
+			      <0xfc4cb000 0x1000>,
+			      <0xfc4ca000 0x1000>;
+			interrupt-names = "periph_irq";
+			interrupts = <0 190 0>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
 	};
 };
--
1.9.1
