From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  1 Jul 2014 15:30:47 +0100
Subject: [PATCH 3/3] ARM: STi: STiH407: Add reset controller support.
In-Reply-To: <1404225047-9495-1-git-send-email-peter.griffin@linaro.org>
References: <1404225047-9495-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1404225047-9495-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the reset controller DT nodes for the powerdown,
 softreset and picophy controllers.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 4f9024f..e8fbb88 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-clock.dtsi"
 #include "stih407-pinctrl.dtsi"
+#include <dt-bindings/reset-controller/stih407-resets.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -63,6 +64,21 @@
 		ranges;
 		compatible = "simple-bus";
 
+		powerdown: powerdown-controller {
+			#reset-cells = <1>;
+			compatible = "st,stih407-powerdown";
+		};
+
+		softreset: softreset-controller {
+			#reset-cells = <1>;
+			compatible = "st,stih407-softreset";
+		};
+
+		picophyreset: picophyreset-controller {
+			#reset-cells = <1>;
+			compatible = "st,stih407-picophyreset";
+		};
+
 		syscfg_sbc: sbc-syscfg at 9620000 {
 			compatible = "st,stih407-sbc-syscfg", "syscon";
 			reg = <0x9620000 0x1000>;
-- 
1.9.1
