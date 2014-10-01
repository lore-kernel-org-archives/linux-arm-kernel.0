From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed,  1 Oct 2014 12:03:17 -0500
Subject: [PATCH 4/4] ARM: qcom: add description of KPSS WDT for MSM8960
In-Reply-To: <cover.1412182773.git.joshc@codeaurora.org>
References: <cover.1412182773.git.joshc@codeaurora.org>
Message-ID: <bc0f43ba33aee728afb4459090e0234008361be9.1412182773.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the Krait Processor Sub-system (KPSS) Watchdog timer in the
MSM8960 device tree.  Also, add a fixed-clock description of SLEEP_CLK,
which will do for now.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1b0d5c..072866b 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -48,6 +48,14 @@
 		qcom,no-pc-write;
 	};
 
+	clocks {
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			#clock-cells = <0>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -73,6 +81,13 @@
 			cpu-offset = <0x80000>;
 		};
 
+		watchdog at 208a038 {
+			compatible = "qcom,kpss-wdt-msm8960";
+			reg = <0x0208a038 0x40>;
+			clocks = <&sleep_clk>;
+			timeout-sec = <10>;
+		};
+
 		msmgpio: gpio at 800000 {
 			compatible = "qcom,msm-gpio";
 			gpio-controller;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
