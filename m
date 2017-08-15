From: weiyi.lu@mediatek.com (weiyi.lu at mediatek.com)
Date: Tue, 15 Aug 2017 14:42:45 +0800
Subject: [PATCH v1 4/9] arm: dts: mt2712: Add clock controller device nodes
In-Reply-To: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
References: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1502779370-30150-5-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add clock controller nodes for MT2712, include topckgen, infracfg,
pericfg, mcucfg and apmixedsys. This patch also add six oscillators that
provide clocks for MT2712.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 115 ++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 92e4c50..6338a1f 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -5,6 +5,7 @@
  * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
+#include <dt-bindings/clock/mt2712-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "mt2712-pinfunc.h"
@@ -74,6 +75,48 @@
 		#clock-cells = <0>;
 	};
 
+	clk26m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clk32k: oscillator at 1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
+	};
+
+	clkfpc: oscillator at 2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "clkfpc";
+	};
+
+	clkaud_ext_i_0: oscillator at 3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <6500000>;
+		clock-output-names = "clkaud_ext_i_0";
+	};
+
+	clkaud_ext_i_1: oscillator at 4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <196608000>;
+		clock-output-names = "clkaud_ext_i_1";
+	};
+
+	clkaud_ext_i_2: oscillator at 5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <180633600>;
+		clock-output-names = "clkaud_ext_i_2";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -87,6 +130,24 @@
 			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	topckgen: syscon at 10000000 {
+		compatible = "mediatek,mt2712-topckgen", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	infracfg: syscon at 10001000 {
+		compatible = "mediatek,mt2712-infracfg", "syscon";
+		reg = <0 0x10001000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	pericfg: syscon at 10003000 {
+		compatible = "mediatek,mt2712-pericfg", "syscon";
+		reg = <0 0x10003000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	syscfg_pctl_a: syscfg_pctl_a at 10005000 {
 		compatible = "mediatek,mt2712-pctl-a-syscfg", "syscon";
 		reg = <0 0x10005000 0 0x1000>;
@@ -114,6 +175,18 @@
 		status = "disabled";
 	};
 
+	apmixedsys: syscon at 10209000 {
+		compatible = "mediatek,mt2712-apmixedsys", "syscon";
+		reg = <0 0x10209000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mcucfg: syscon at 10220000 {
+		compatible = "mediatek,mt2712-mcucfg", "syscon";
+		reg = <0 0x10220000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	sysirq: interrupt-controller at 10220a80 {
 		compatible = "mediatek,mt2712-sysirq",
 			     "mediatek,mt6577-sysirq";
@@ -185,5 +258,47 @@
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
+
+	mfgcfg: syscon at 13000000 {
+		compatible = "mediatek,mt2712-mfgcfg", "syscon";
+		reg = <0 0x13000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mmsys: syscon at 14000000 {
+		compatible = "mediatek,mt2712-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	imgsys: syscon at 15000000 {
+		compatible = "mediatek,mt2712-imgsys", "syscon";
+		reg = <0 0x15000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	bdpsys: syscon at 15010000 {
+		compatible = "mediatek,mt2712-bdpsys", "syscon";
+		reg = <0 0x15010000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vdecsys: syscon at 16000000 {
+		compatible = "mediatek,mt2712-vdecsys", "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vencsys: syscon at 18000000 {
+		compatible = "mediatek,mt2712-vencsys", "syscon";
+		reg = <0 0x18000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	jpgdecsys: syscon at 19000000 {
+		compatible = "mediatek,mt2712-jpgdecsys", "syscon";
+		reg = <0 0x19000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
 
-- 
1.9.1
