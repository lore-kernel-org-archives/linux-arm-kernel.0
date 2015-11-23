From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 11:04:07 -0800
Subject: [PATCH] ARM: dts: qcom: msm8974: Disable wled and move it to honami
Message-ID: <1448305447-9092-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The properties specified in the wled node could harm connected hardware,
so move the properties to Honami and disable the platform node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 13 +++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                    |  9 ++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 37741725b7bd..a0398b69f4f2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -403,4 +403,17 @@
 			qcom,vset-millivolts = <3000>;
 		};
 	};
+
+	pm8941 at 1 {
+		wled at d800 {
+			status = "ok";
+
+			qcom,cs-out;
+			qcom,current-limit = <20>;
+			qcom,current-boost-limit = <805>;
+			qcom,switching-freq = <1600>;
+			qcom,ovp = <29>;
+			qcom,num-strings = <2>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index b0d443999fcc..b73fee57cf18 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -159,17 +159,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		wled at d800 {
+		pm8941_wled: wled at d800 {
 			compatible = "qcom,pm8941-wled";
 			reg = <0xd800 0x100>;
 			label = "backlight";
 
-			qcom,cs-out;
-			qcom,current-limit = <20>;
-			qcom,current-boost-limit = <805>;
-			qcom,switching-freq = <1600>;
-			qcom,ovp = <29>;
-			qcom,num-strings = <2>;
+			status = "disabled";
 		};
 	};
 };
-- 
2.4.2
