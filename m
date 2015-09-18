From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:19 +0100
Subject: [PATCH 05/14] ARM: dts: apq8064: add pm8921 rtc
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579479-20144-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds rtc node for pmic8921.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d973832..1d4fa2b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -372,6 +372,14 @@
 					<136 1>, <137 1>, <138 1>, <139 1>;
 				};
 
+				rtc at 11d {
+					compatible = "qcom,pm8921-rtc";
+					interrupt-parent = <&pmicintc>;
+					interrupts = <39 1>;
+					reg = <0x11d>;
+					allow-set-time;
+				};
+
 			};
 		};
 
-- 
1.9.1
