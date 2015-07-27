From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 27 Jul 2015 14:52:02 +0100
Subject: [PATCH v1 5/7] ARM: dts: apq8064: add pm8921 mpp support
In-Reply-To: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438005122-16475-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pmic pm8921 mpp gpio controller node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 647a7e0..da214f1 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -320,6 +320,18 @@
 					#gpio-cells = <2>;
 
 				};
+
+				pm8921_mpps: mpps at 50 {
+					compatible = "qcom,pm8921-mpp";
+					reg = <0x50>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupts =
+					<128 1>, <129 1>, <130 1>, <131 1>,
+					<132 1>, <133 1>, <134 1>, <135 1>,
+					<136 1>, <137 1>, <138 1>, <139 1>;
+				};
+
 			};
 		};
 
-- 
1.9.1
