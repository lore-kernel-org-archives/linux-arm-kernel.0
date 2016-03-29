From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:04 -0700
Subject: [PATCH v2 8/9] ARM: dts: qcom: apq8064: Add smd node and all edges
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-9-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Andy, this is only here for context, please apply separately.

Changes since v1:
- Added dts patches

 arch/arm/boot/dts/qcom-apq8064.dtsi | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 5a9d68287840..ad7bc3c2aad1 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -124,6 +124,46 @@
 		hwlocks = <&sfpb_mutex 3>;
 	};
 
+	smd {
+		compatible = "qcom,smd";
+
+		modem at 0 {
+			interrupts = <0 37 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&l2cc 8 3>;
+			qcom,smd-edge = <0>;
+
+			status = "disabled";
+		};
+
+		q6 at 1 {
+			interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&l2cc 8 15>;
+			qcom,smd-edge = <1>;
+
+			status = "disabled";
+		};
+
+		dsps at 3 {
+			interrupts = <0 138 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&sic_non_secure 0x4080 0>;
+			qcom,smd-edge = <3>;
+
+			status = "disabled";
+		};
+
+		riva at 6 {
+			interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&l2cc 8 25>;
+			qcom,smd-edge = <6>;
+
+			status = "disabled";
+		};
+	};
+
 	smsm {
 		compatible = "qcom,smsm";
 
-- 
2.5.0
