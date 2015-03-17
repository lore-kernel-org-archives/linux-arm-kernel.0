From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Mar 2015 16:33:45 -0600
Subject: [PATCH v16 05/11] ARM: dts: qcom: Add power-controller device node
 for 8074 Krait CPUs
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1426631631-56937-6-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller to
regulate the power to the cpu and aide the core in entering idle states.
Reference the SAW instance and associate the instance with the CPU core.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e265ec1..5a41f44 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -21,6 +21,7 @@
 			reg = <0>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			qcom,saw = <&saw0>;
 		};
 
 		cpu at 1 {
@@ -30,6 +31,7 @@
 			reg = <1>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			qcom,saw = <&saw1>;
 		};
 
 		cpu at 2 {
@@ -39,6 +41,7 @@
 			reg = <2>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			qcom,saw = <&saw2>;
 		};
 
 		cpu at 3 {
@@ -48,6 +51,7 @@
 			reg = <3>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			qcom,saw = <&saw3>;
 		};
 
 		L2: l2-cache {
@@ -144,7 +148,27 @@
 			};
 		};
 
-		saw_l2: regulator at f9012000 {
+		saw0: power-controller at f9089000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw1: power-controller at f9099000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw2: power-controller at f90a9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw3: power-controller at f90b9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw_l2: power-controller at f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
2.1.0
