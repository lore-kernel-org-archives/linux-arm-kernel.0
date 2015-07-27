From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 27 Jul 2015 14:50:12 +0100
Subject: [PATCH v1 2/7] ARM: dts: ifc6410: add real regulators for sdcc nodes.
In-Reply-To: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438005012-16263-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds real regulators for all the three sdcc nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index a7c939b..cdfcf02 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -73,6 +73,12 @@
 					bias-pull-down;
 				};
 
+				pm8921_l5: l5 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
 				pm8921_l6: l6 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
@@ -84,6 +90,10 @@
 					regulator-max-microvolt = <1900000>;
 					bias-pull-down;
 				};
+
+				pm8921_lvs1: lvs1 {
+					bias-pull-down;
+				};
 			};
 		};
 
@@ -175,11 +185,14 @@
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
 				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+				vqmmc-supply = <&pm8921_s4>;
 			};
 
 			/* External micro SD card */
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
+				vmmc-supply = <&pm8921_l6>;
 				pinctrl-names	= "default";
 				pinctrl-0	= <&card_detect>;
 				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
@@ -187,6 +200,8 @@
 			/* WLAN */
 			sdcc4: sdcc at 121c0000 {
 				status = "okay";
+				vmmc-supply = <&ext_3p3v>;
+				vqmmc-supply = <&pm8921_lvs1>;
 			};
 		};
 	};
-- 
1.9.1
