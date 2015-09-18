From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:25 +0100
Subject: [PATCH 06/14] ARM: dts: apq8064: add pm8921 pwrkey support
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579485-20187-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to pm8921 power button.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1d4fa2b..4a2f159 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -380,6 +380,14 @@
 					allow-set-time;
 				};
 
+				pwrkey at 1c {
+					compatible = "qcom,pm8921-pwrkey";
+					reg = <0x1c>;
+					interrupt-parent = <&pmicintc>;
+					interrupts = <50 1>, <51 1>;
+					debounce = <15625>;
+					pull-up;
+				};
 			};
 		};
 
-- 
1.9.1
