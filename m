From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue,  7 Oct 2014 15:31:21 -0600
Subject: [PATCH 3/7] arm: dts: qcom: Add power-controller device node for 8084
 Krait CPUs
In-Reply-To: <1412717485-16892-1-git-send-email-lina.iyer@linaro.org>
References: <1412717485-16892-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1412717485-16892-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each Krait CPU in the QCOM 8084 SoC has an SAW power controller to
regulate the power to the cpu and aide the core in entering idle states.
Reference the SAW instance and associate the instance with the CPU core.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index e3e009a..1581b12 100644
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
+		saw0: power-controller at f9089000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>;
+		};
+
+		saw1: power-controller at f9099000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>;
+		};
+
+		saw2: power-controller at f90a9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>;
+		};
+
+		saw3: power-controller at f90b9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>;
+		};
+
+		saw_l2: power-controller at f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
1.9.1
