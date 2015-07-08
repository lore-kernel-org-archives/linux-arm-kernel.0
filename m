From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed,  8 Jul 2015 15:17:17 +0530
Subject: [PATCH 8/9] arm: dts: apq8084: Add thermal zones,
 tsens and eeprom nodes
In-Reply-To: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1436348838-22671-9-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal zones, tsens and eeprom nodes

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 105 ++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7084010..05e83ea 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -75,6 +75,88 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu_alert0: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				cpu_alert1: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu_alert2: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit2: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu_alert3: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit3: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <1 7 0xf04>;
@@ -103,6 +185,29 @@
 			      <0xf9002000 0x1000>;
 		};
 
+		qfprom: qfprom at fc4bc000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "qcom,qfprom";
+			reg = <0xfc4bc000 0x1000>;
+			tsens_calib: calib at d0 {
+				reg = <0xd0 0x18>;
+			};
+			tsens_backup: backup at 440 {
+				reg = <0x440 0x10>;
+			};
+		};
+
+		tsens: thermal-sensor at fc4a8000 {
+			compatible = "qcom,msm8974-tsens";
+			reg = <0xfc4a8000 0x2000>;
+			nvmem-cell = <&tsens_calib>, <&tsens_backup>;
+			nvmem-cell-names = "calib", "calib_backup";
+			qcom,tsens-slopes = <3200 3200 3200 3200 3200 3200
+				3200 3200 3200 3200 3200>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
