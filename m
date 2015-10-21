From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:47 -0700
Subject: [PATCH 4/7] ARM: dts: qcom: msm8974-honami: Add sdhci1 node
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-4-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the eMMC sdhci node and its pinctrl state.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 8c0753a32b20..de3529d1a8ca 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -277,6 +277,19 @@
 };
 
 &soc {
+	sdhci at f9824900 {
+		status = "ok";
+
+		vmmc-supply = <&pm8941_l20>;
+		vqmmc-supply = <&pm8941_s3>;
+
+		bus-width = <8>;
+		non-removable;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhc1_pin_a>;
+	};
+
 	serial at f991e000 {
 		status = "ok";
 
@@ -302,6 +315,20 @@
 				bias-disable;
 			};
 		};
+
+		sdhc1_pin_a: sdhc1-pin-active {
+			clk {
+				pins = "sdc1_clk";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			cmd-data {
+				pins = "sdc1_cmd", "sdc1_data";
+				drive-strength = <10>;
+				bias-pull-up;
+			};
+		};
 	};
 };
 
-- 
2.4.2
