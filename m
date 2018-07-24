From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 24 Jul 2018 16:46:35 -0700
Subject: [PATCH v5 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
Message-ID: <20180724234636.57137-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v5:
- added tag 'Reviewed-by: Douglas Anderson <dianders@chromium.org>'

Changes in v4:
- none

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
2.18.0.233.g985f88cf7e-goog
