From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:03 -0700
Subject: [PATCH v2 7/9] ARM: dts: qcom: apq8064: Add complete smsm node
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-8-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Andy, this is only here for context, please apply separately.

Changes since v1:
- Added dts patches

 arch/arm/boot/dts/qcom-apq8064.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9d45c4ef4a97..5a9d68287840 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -124,6 +124,55 @@
 		hwlocks = <&sfpb_mutex 3>;
 	};
 
+	smsm {
+		compatible = "qcom,smsm";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		qcom,ipc-1 = <&l2cc 8 4>;
+		qcom,ipc-2 = <&l2cc 8 14>;
+		qcom,ipc-3 = <&l2cc 8 23>;
+		qcom,ipc-4 = <&sic_non_secure 0x4094 0>;
+
+		apps_smsm: apps at 0 {
+			reg = <0>;
+			#qcom,state-cells = <1>;
+		};
+
+		modem_smsm: modem at 1 {
+			reg = <1>;
+			interrupts = <0 38 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		q6_smsm: q6 at 2 {
+			reg = <2>;
+			interrupts = <0 89 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wcnss_smsm: wcnss at 3 {
+			reg = <3>;
+			interrupts = <0 204 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		dsps_smsm: dsps at 4 {
+			reg = <4>;
+			interrupts = <0 137 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.5.0
