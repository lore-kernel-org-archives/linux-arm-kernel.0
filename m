From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Fri, 30 Jun 2017 15:38:01 +0530
Subject: [PATCH] dts: ipq4019: Move xo and timer nodes to SoC dtsi
Message-ID: <1498817281-30608-1-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The node for xo and timer belong to the SoC DTS file.
Else, new board DT files may not inherit these nodes.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 19 -------------------
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index b9457dd..b74c113 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -20,26 +20,7 @@
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
-
-
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <1 2 0xf08>,
-				     <1 3 0xf08>,
-				     <1 4 0xf08>,
-				     <1 1 0xf08>;
-			clock-frequency = <48000000>;
-		};
-
 		pinctrl at 0x01000000 {
 			serial_pins: serial_pinmux {
 				mux {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b7a24af..e8ab1e1 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -96,6 +96,11 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+		xo: xo {
+			compatible = "fixed-clock";
+			clock-frequency = <48000000>;
+			#clock-cells = <0>;
+		};
 	};
 
 	soc {
@@ -104,6 +109,15 @@
 		ranges;
 		compatible = "simple-bus";
 
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <1 2 0xf08>,
+				     <1 3 0xf08>,
+				     <1 4 0xf08>,
+				     <1 1 0xf08>;
+			clock-frequency = <48000000>;
+		};
+
 		intc: interrupt-controller at b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
