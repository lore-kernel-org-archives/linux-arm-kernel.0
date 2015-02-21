From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Fri, 20 Feb 2015 18:19:35 -0800
Subject: [PATCH 2/3] ARM: qcom: add description of KPSS WDT for IPQ8064
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the watchdog related entries to the Krait Processor Sub-system
(KPSS) timer IPQ8064 devicetree section. Also, add a fixed-clock
description of SLEEP_CLK, which will do for now.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225da..d01f618 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -60,6 +60,14 @@
 		};
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
@@ -89,10 +97,14 @@
 			compatible = "qcom,kpss-timer", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
-				     <1 3 0x301>;
+				     <1 3 0x301>,
+				     <1 4 0x301>,
+				     <1 5 0x301>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <25000000>,
 					  <32768>;
+			clocks = <&sleep_clk>;
+			clock-names = "sleep";
 			cpu-offset = <0x80000>;
 		};
 
-- 
1.9.1
