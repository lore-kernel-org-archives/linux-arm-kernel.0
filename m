From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 5 Jun 2015 15:52:25 -0700
Subject: [PATCH 3/3] ARM: dts: qcom: Replace gpio node with pinctrl node
In-Reply-To: <1433544745-325-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1433544745-325-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1433544745-325-4-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the standalone gpio driver with pinctrl-msm as we now have
msm8660 support there.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 20bbd19b996e..28bba8b09854 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -62,15 +62,16 @@
 			cpu-offset = <0x40000>;
 		};
 
-		msmgpio: gpio at 800000 {
-			compatible = "qcom,msm-gpio";
-			reg = <0x00800000 0x4000>;
+		tlmm: pinctrl at 800000 {
+			compatible = "qcom,msm8660-pinctrl";
+			reg = <0x800000 0x4000>;
+
 			gpio-controller;
 			#gpio-cells = <2>;
-			ngpio = <173>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
 		};
 
 		gcc: clock-controller at 900000 {
@@ -110,7 +111,7 @@
 
 			pmicintc: pmic at 0 {
 				compatible = "qcom,pm8058";
-				interrupt-parent = <&msmgpio>;
+				interrupt-parent = <&tlmm>;
 				interrupts = <88 8>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
-- 
1.8.2.2
