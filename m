From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 18 Jun 2018 14:50:51 -0700
Subject: [PATCH v2 2/2] arm64: dts: sdm845: Add rpmh-clk node
In-Reply-To: <20180618215051.156270-1-dianders@chromium.org>
References: <20180618215051.156270-1-dianders@chromium.org>
Message-ID: <20180618215051.156270-2-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the rpmh-clk node to sdm845 based on the examples in the
bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: to apply this patch cleanly, apply it atop:
  arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
  https://patchwork.kernel.org/patch/10462691/

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 43a182fb42c9..00722b533a92 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -1001,6 +1002,11 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sdm845-rpmh-clk";
+				#clock-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller at 17a00000 {
-- 
2.18.0.rc1.244.gcf134e6275-goog
