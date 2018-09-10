From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 10 Sep 2018 09:03:00 -0700
Subject: [PATCH v3 2/3] arm64: dts: qcom: pm8998: Add adc node
In-Reply-To: <20180910160301.237538-1-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
Message-ID: <20180910160301.237538-3-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the adc node to pm8998 based on the examples in the
bindings. It also fixes the order of the included headers.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v3:
- fixed separator in commit message
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- removed io-channel-ranges attribute
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..41593ebbea2c 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic at 0 {
@@ -11,6 +12,15 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_adc: adc at 3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+		};
+
 		pm8998_gpio: gpios at c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
