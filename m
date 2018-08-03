From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri,  3 Aug 2018 15:20:59 -0700
Subject: [PATCH] arm64: dts: sdm845: Add dispcc node
Message-ID: <20180803222059.146666-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the display clock controller node to sdm845 based on the
examples in the bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
The dispcc driver and DT bindings landed in the clk-qcom-dispcc-845
branch of the clk tree.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9c10ff5e5843..d0b4a78c79e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -962,6 +963,14 @@
 			};
 		};
 
+		dispcc: clock-controller at af00000 {
+			compatible = "qcom,sdm845-dispcc";
+			reg = <0xaf00000 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi at c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.18.0.597.ga71716f1ad-goog
