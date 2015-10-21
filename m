From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:48 -0700
Subject: [PATCH 5/7] ARM: dts: qcom: msm8974-honami: Add uSD slot nodes
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-5-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and enable the sdhci2 slot, the pinctrl configuration and card
detect.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index de3529d1a8ca..113cc18ee2f5 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -290,6 +290,20 @@
 		pinctrl-0 = <&sdhc1_pin_a>;
 	};
 
+	sdhci at f98a4900 {
+		status = "ok";
+
+		bus-width = <4>;
+
+		vmmc-supply = <&pm8941_l21>;
+		vqmmc-supply = <&pm8941_l13>;
+
+		cd-gpios = <&msmgpio 62 GPIO_ACTIVE_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+	};
+
 	serial at f991e000 {
 		status = "ok";
 
@@ -329,6 +343,29 @@
 				bias-pull-up;
 			};
 		};
+
+		sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+			pins = "gpio62";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-disable;
+		 };
+
+		sdhc2_pin_a: sdhc2-pin-active {
+			clk {
+				pins = "sdc2_clk";
+				drive-strength = <10>;
+				bias-disable;
+			};
+
+			cmd-data {
+				pins = "sdc2_cmd", "sdc2_data";
+				drive-strength = <6>;
+				bias-pull-up;
+			};
+		};
+
 	};
 };
 
-- 
2.4.2
