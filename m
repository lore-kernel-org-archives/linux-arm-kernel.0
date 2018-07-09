From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon,  9 Jul 2018 14:25:21 -0700
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Message-ID: <20180709212522.187257-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- changed node name from 'qcom,temp-alarm at 2400' to 'temp-alarm at 2400'
- removed controller register length value from 'reg'

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..7eea94701b23 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: temp-alarm at 2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios at c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.203.gfac676dfb9-goog
