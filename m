From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 18 Aug 2015 14:10:09 +0100
Subject: [PATCH v2 3/6] ARM: dts: apq8064-ifc6410: add notify led support.
In-Reply-To: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1439903409-20233-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds notify led support on IFC6410, whose trigger can be
configured from userspace.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index b1f9ddb..08daafe 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -221,6 +221,18 @@
 			status = "okay";
 		};
 
+		leds {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&notify_led>;
+
+			led at 1 {
+				label = "apq8064:green:user1";
+				gpios = <&pm8921_gpio 18 GPIO_ACTIVE_HIGH>;
+				default-state = "on";
+			};
+		};
+
 		qcom,ssbi at 500000 {
 			pmic at 0 {
 				gpio at 150 {
@@ -232,6 +244,15 @@
 							power-source = <PM8921_GPIO_S4>;
 						};
 					};
+
+					notify_led: nled {
+						pios {
+							pins = "gpio18";
+							function = "normal";
+							bias-disable;
+							power-source = <PM8921_GPIO_S4>;
+						};
+					};
 				};
 			};
 		};
-- 
1.9.1
