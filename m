From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 23 Apr 2015 19:16:13 +0530
Subject: [RFC 7/7] arm: dts: apq8064: Add thermal zones, tsens and eeprom nodes
In-Reply-To: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1429796773-7151-8-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal zones, tsens and eeprom nodes

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 108 ++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b3154c0..1aed325 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -61,6 +61,88 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu_alert0: trip at 0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip at 1 {
+					temperature = <125000>;
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
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu_alert1: trip at 0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip at 1 {
+					temperature = <125000>;
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
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				cpu_alert2: trip at 0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit2: trip at 1 {
+					temperature = <125000>;
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
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				cpu_alert3: trip at 0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit3: trip at 1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <1 10 0x304>;
@@ -232,11 +314,37 @@
 			qcom,controller-type = "pmic-arbiter";
 		};
 
+		qfprom: qfprom at 00700000 {
+			compatible	= "qcom,qfprom";
+			reg		= <0x00700000 0x1000>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+			tsens_calib: calib {
+				reg = <0x404 0x10>;
+			};
+			tsens_backup: backup_calib {
+				reg = <0x414 0x10>;
+			};
+		};
+
 		gcc: clock-controller at 900000 {
 			compatible = "qcom,gcc-apq8064";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+
+			tsens: thermal-sensor at 900000 {
+				compatible = "qcom,msm8960-tsens";
+				calib = <&tsens_calib>;
+				calib_backup = <&tsens_backup>;
+				qcom,tsens-slopes = <1176 1176 1154 1176 1111
+					1132 1132 1199 1132 1199 1132>;
+				#thermal-sensor-cells = <1>;
+			};
 		};
 
 		mmcc: clock-controller at 4000000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
