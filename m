From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue,  8 Jul 2014 18:54:29 +0300
Subject: [PATCH 3/3] dt: qcom: msm8974: add qpnp-spmi device nodes
In-Reply-To: <1404834869-23049-1-git-send-email-svarbanov@mm-sol.com>
References: <1404834869-23049-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <1404834869-23049-4-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ivan T. Ivanov <iivanov@mm-sol.com>

The qpnp-spmi device nodes are childrens of spmi pmic arbiter.
msm8974 SoC using two pmic chips pm8941 and pm8841. Every chip
has two spmi-qpnp bus id's.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi |   45 +++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 69dca2a..9166b8e 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -3,6 +3,7 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	model = "Qualcomm MSM8974";
@@ -236,5 +237,49 @@
 			#interrupt-cells = <2>;
 			interrupts = <0 208 0>;
 		};
+
+		spmi at fc4cf000 {
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
+
+			usid0: pm8941 at 0 {
+				compatible = "qcom,qpnp-spmi";
+				reg = <0x0 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			usid1: pm8941 at 1 {
+				compatible = "qcom,qpnp-spmi";
+				reg = <0x1 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			usid4: pm8841 at 4 {
+				compatible = "qcom,qpnp-spmi";
+				reg = <0x4 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			usid5: pm8841 at 5 {
+				compatible = "qcom,qpnp-spmi";
+				reg = <0x5 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
 	};
 };
-- 
1.7.0.4
