From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 18 Aug 2015 14:10:37 +0100
Subject: [PATCH v2 6/6] ARM: dts: qs600: Add SD card detect support.
In-Reply-To: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1439903437-20360-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SD card detect support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index c095849..8c7bdc4 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -25,6 +25,16 @@
 	};
 
 	soc {
+		pinctrl at 800000 {
+			card_detect: card_detect {
+				mux {
+					pins = "gpio26";
+					function = "gpio";
+					bias-disable;
+				};
+			};
+		};
+
 		rpm at 108000 {
 			regulators {
 				vin_lvs1_3_6-supply = <&pm8921_s4>;
@@ -193,6 +203,9 @@
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
 				vmmc-supply = <&v3p3_fixed>;
+				pinctrl-names	= "default";
+				pinctrl-0	= <&card_detect>;
+				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
 			};
 			/* WLAN */
 			sdcc4: sdcc at 121c0000 {
-- 
1.9.1
