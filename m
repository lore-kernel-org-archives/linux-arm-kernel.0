From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 29 Dec 2016 04:06:11 -0800
Subject: [PATCH v2] ARM: dts: qcom: apq8064: Add missing scm clock
Message-ID: <20161229120611.7948-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the device tree binding the apq8064 scm node requires the core
clock to be specified, so add this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Changed clock to Daytona Fabric

 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1dbe697b2e90..a27cc96ac069 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -303,6 +304,9 @@
 	firmware {
 		scm {
 			compatible = "qcom,scm-apq8064";
+
+			clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>;
+			clock-names = "core";
 		};
 	};
 
-- 
2.11.0
