From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue, 19 Aug 2014 20:22:16 +0300
Subject: [PATCH v1 3/3] ARM: dts: Add TLMM DT node for apq8084
In-Reply-To: <1408468936-12252-1-git-send-email-gdjakov@mm-sol.com>
References: <1408468936-12252-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1408468936-12252-4-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the TLMM node for the apq8084 platform.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index b5b156e..21d01e5 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -185,6 +185,16 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		tlmm: pinctrl at fd510000 {
+			compatible = "qcom,apq8084-pinctrl";
+			reg = <0xfd510000 0x4000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 208 0>;
+		};
+
 		serial at f995e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf995e000 0x1000>;
-- 
1.7.9.5
