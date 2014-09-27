From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Sep 2014 18:58:11 -0600
Subject: [PATCH v7 3/7] arm: dts: qcom: Add SPM device bindings for 8084
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1411779495-39724-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPM device bindings for QCOM 8084 based cpus. SPM is the sub-system
power manager and controls the logic around the cores (cpu and L2).

Each core has an instance of SPM and controls only that core. Each cpu
SPM is configured to support WFI and SPC (standalone-power collapse).

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index e3e009a..3dda230 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -18,6 +18,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			qcom,saw = <&saw0>;
 		};
 
 		cpu at 1 {
@@ -27,6 +28,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			qcom,saw = <&saw1>;
 		};
 
 		cpu at 2 {
@@ -36,6 +38,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			qcom,saw = <&saw2>;
 		};
 
 		cpu at 3 {
@@ -45,6 +48,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			qcom,saw = <&saw3>;
 		};
 
 		L2: l2-cache {
@@ -141,7 +145,27 @@
 			};
 		};
 
-		saw_l2: regulator at f9012000 {
+		saw0: saw at f9089000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>;
+		};
+
+		saw1: saw at f9099000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>;
+		};
+
+		saw2: saw at f90a9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>;
+		};
+
+		saw3: saw at f90b9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>;
+		};
+
+		saw_l2: saw at f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
1.9.1
