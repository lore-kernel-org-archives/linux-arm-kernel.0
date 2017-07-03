From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon,  3 Jul 2017 13:04:44 +0530
Subject: [PATCH v2 2/2] Subject: [PATCH] dts: ipq4019: Move xo and timer nodes
 to SoC dtsi
In-Reply-To: <1499067284-21008-1-git-send-email-varada@codeaurora.org>
References: <1499067284-21008-1-git-send-email-varada@codeaurora.org>
Message-ID: <1499067284-21008-3-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node for xo and timer belong to the SoC DTS file.
Else, new board DT files may not inherit these nodes.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi |  8 --------
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index de83bc9..c055a57 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -20,14 +20,6 @@
 	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
 	compatible = "qcom,ipq4019";
 
-	clocks {
-                xo: xo {
-                        compatible = "fixed-clock";
-                        clock-frequency = <48000000>;
-                        #clock-cells = <0>;
-                };
-	};
-
 	soc {
 		pinctrl at 1000000 {
 			serial_pins: serial_pinmux {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 6defd0e..f4765e4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -96,6 +96,21 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+
+		xo: xo {
+			compatible = "fixed-clock";
+			clock-frequency = <48000000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 2 0xf08>,
+			     <1 3 0xf08>,
+			     <1 4 0xf08>,
+			     <1 1 0xf08>;
+		clock-frequency = <48000000>;
 	};
 
 	soc {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
