From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu,  9 Jul 2015 18:27:41 +0800
Subject: [PATCH v6 4/4] arm64: dts: mt8173: Add mt8173 cpufreq driver support
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1436437661-17606-5-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required properties in device tree to enable MT8173
cpufreq driver.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
It is based on the top of Mediatek SoC maintainer's tree[1] and the
patch that adds cpumux clocks for MT8173[2]

[1] https://github.com/mbgg/linux-mediatek.git v4.2-next/arm64
    commit id: 16ea61fc56144f1860f9edd5a219666ade01d3b8
[2] http://marc.info/?l=devicetree&m=143617720314125&w=2
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 64 +++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 986f25f..c47f8d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -261,6 +261,24 @@
 	};
 };
 
+&cpu0 {
+	proc-supply = <&mt6397_vpca15_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6397_vpca15_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 359b8b6..47a443d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -53,6 +53,22 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points = <
+				507000	859000
+				702000	908000
+				1001000	983000
+				1105000	1009000
+				1183000	1028000
+				1404000	1083000
+				1508000	1109000
+				1573000	1125000
+			>;
+			#cooling-cells = <2>;
+			#cooling-min-level = <0>;
+			#cooling-max-level = <7>;
 		};
 
 		cpu1: cpu at 1 {
@@ -61,6 +77,22 @@
 			reg = <0x001>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points = <
+				507000	859000
+				702000	908000
+				1001000	983000
+				1105000	1009000
+				1183000	1028000
+				1404000	1083000
+				1508000	1109000
+				1573000	1125000
+			>;
+			#cooling-cells = <2>;
+			#cooling-min-level = <0>;
+			#cooling-max-level = <7>;
 		};
 
 		cpu2: cpu at 100 {
@@ -69,6 +101,22 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points = <
+				507000	828000
+				702000	867000
+				1001000	927000
+				1209000	968000
+				1404000	1007000
+				1612000	1049000
+				1807000	1089000
+				1989000	1125000
+			>;
+			#cooling-cells = <2>;
+			#cooling-min-level = <0>;
+			#cooling-max-level = <7>;
 		};
 
 		cpu3: cpu at 101 {
@@ -77,6 +125,22 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points = <
+				507000	828000
+				702000	867000
+				1001000	927000
+				1209000	968000
+				1404000	1007000
+				1612000	1049000
+				1807000	1089000
+				1989000	1125000
+			>;
+			#cooling-cells = <2>;
+			#cooling-min-level = <0>;
+			#cooling-max-level = <7>;
 		};
 
 		idle-states {
-- 
1.9.1
