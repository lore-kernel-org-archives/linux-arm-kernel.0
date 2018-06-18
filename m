From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 18 Jun 2018 13:56:15 -0700
Subject: [PATCH 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Message-ID: <20180618205616.102750-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the rpmh-rsc node to sdm845 based on the examples in the
bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cd308b84bed7..19b006293d3b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -984,6 +985,24 @@
 			#mbox-cells = <1>;
 		};
 
+		apps_rsc: rsc at 179c0000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x179c0000 0x10000>,
+			      <0x179d0000 0x10000>,
+			      <0x179e0000 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <SLEEP_TCS   3>,
+					  <WAKE_TCS    3>,
+					  <ACTIVE_TCS  2>,
+					  <CONTROL_TCS 1>;
+		};
+
 		intc: interrupt-controller at 17a00000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <1>;
-- 
2.18.0.rc1.244.gcf134e6275-goog
