From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Mar 2015 16:33:47 -0600
Subject: [PATCH v16 07/11] ARM: dts: qcom: Update power-controller device node
 for 8064 Krait CPUs
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1426631631-56937-8-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the SAW2 DT bindings to add qcom,apq8064-saw2-v1.1-cpu compatible
binding string to configure SPM registers and allow the SPM to put the
core in deeper idle states when the core is idle.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b3154c0..9fd24bc 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -139,26 +139,26 @@
 			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
 		};
 
-		saw0: regulator at 2089000 {
-			compatible = "qcom,saw2";
+		saw0: power-controller at 2089000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw1: regulator at 2099000 {
-			compatible = "qcom,saw2";
+		saw1: power-controller at 2099000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw2: regulator at 20a9000 {
-			compatible = "qcom,saw2";
+		saw2: power-controller at 20a9000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw3: regulator at 20b9000 {
-			compatible = "qcom,saw2";
+		saw3: power-controller at 20b9000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
-- 
2.1.0
