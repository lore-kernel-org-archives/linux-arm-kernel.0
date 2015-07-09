From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu,  9 Jul 2015 18:27:39 +0800
Subject: [PATCH v6 2/4] dt-bindings: mediatek: Add MT8173 cpufreq driver
 bindings
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1436437661-17606-3-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding document for MT8173 cpufreq driver.
The clock and regulator consumer properties are documented in
Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt and
referenced by this document.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
new file mode 100644
index 0000000..f23873f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
@@ -0,0 +1,134 @@
+
+Mediatek MT8173 cpufreq driver
+------------------------------
+
+Mediatek MT8173 cpufreq driver for CPU frequency scaling.
+
+Please refer to Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt for details
+about the regulator and clock consumer properties.
+
+Required properties:
+- operating-points: Please refer to Documentation/devicetree/bindings/power/opp.txt for
+		    details.
+
+Optional properties:
+- #cooling-cells:
+- cooling-min-level:
+- cooling-max-level:
+	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
+
+Example:
+--------
+	cpu0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA53SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+		operating-points = <
+			507000	859000
+			702000	908000
+			1001000	983000
+			1105000	1009000
+			1183000	1028000
+			1404000	1083000
+			1508000	1109000
+			1573000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
+	};
+
+	cpu1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA53SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+		operating-points = <
+			507000	859000
+			702000	908000
+			1001000	983000
+			1105000	1009000
+			1183000	1028000
+			1404000	1083000
+			1508000	1109000
+			1573000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
+	};
+
+	cpu2: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+		operating-points = <
+			507000	828000
+			702000	867000
+			1001000	927000
+			1209000	968000
+			1404000	1007000
+			1612000	1049000
+			1807000	1089000
+			1989000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
+	};
+
+	cpu3: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+		operating-points = <
+			507000	828000
+			702000	867000
+			1001000	927000
+			1209000	968000
+			1404000	1007000
+			1612000	1049000
+			1807000	1089000
+			1989000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
+	};
+
+	&cpu0 {
+		proc-supply = <&mt6397_vpca15_reg>;
+	};
+
+	&cpu1 {
+		proc-supply = <&mt6397_vpca15_reg>;
+	};
+
+	&cpu2 {
+		proc-supply = <&da9211_vcpu_reg>;
+		sram-supply = <&mt6397_vsramca7_reg>;
+	};
+
+	&cpu3 {
+		proc-supply = <&da9211_vcpu_reg>;
+		sram-supply = <&mt6397_vsramca7_reg>;
+	};
-- 
1.9.1
