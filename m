From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 23 Mar 2016 19:47:45 +0000
Subject: [PATCH 07/12] ARM: dts: dragonboard-600c: add usb support
In-Reply-To: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1458762465-9630-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb host and otg support on board with required
regulators.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
index a977314..5374510 100644
--- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
@@ -60,6 +60,12 @@
 					bias-pull-down;
 				};
 
+				s3 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1400000>;
+					qcom,switch-mode-frequency = <4800000>;
+				};
+
 				s4 {
 					regulator-min-microvolt	= <1800000>;
 					regulator-max-microvolt	= <1800000>;
@@ -74,6 +80,18 @@
 					qcom,switch-mode-frequency = <3200000>;
 				 };
 
+				l3 {
+					regulator-min-microvolt = <3050000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				l4 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
 				l5 {
 					regulator-min-microvolt = <2750000>;
 					regulator-max-microvolt = <3000000>;
@@ -85,6 +103,12 @@
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
+
+				l23 {
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <1900000>;
+					bias-pull-down;
+				};
 			};
 		};
 
@@ -111,6 +135,46 @@
 			};
 		};
 
+		/* OTG */
+		phy at 12500000 {
+			status		= "okay";
+			dr_mode		= "peripheral";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l4>;
+		};
+
+		phy at 12520000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		phy at 12530000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		gadget at 12500000 {
+			status = "okay";
+		};
+
+		/* OTG */
+		usb at 12500000 {
+			status = "okay";
+		};
+
+		usb at 12520000 {
+			status = "okay";
+		};
+
+		usb at 12530000 {
+			status = "okay";
+		};
+
 		amba {
 			/* eMMC */
 			sdcc at 12400000 {
-- 
2.5.0
