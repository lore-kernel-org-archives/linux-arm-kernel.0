From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 31 Jul 2018 13:38:05 +0800
Subject: [PATCH v4 08/10] arm64: dts: mt8183: Add clock controller device nodes
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1533015487-60189-9-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add clock controller nodes for MT8183, include topckgen, infracfg,
apmixedsys and subsystem.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 92 ++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1553265..6b87a24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -5,6 +5,7 @@
  *	   Erin Lo <erin.lo@mediatek.com>
  */
 
+#include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -112,6 +113,13 @@
 		method          = "smc";
 	};
 
+	clk26m: oscillator at 0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -143,4 +151,88 @@
 		interrupt-parent = <&gic>;
 		reg = <0 0x0c530a80 0 0x50>;
 	};
+
+	topckgen: syscon at 10000000 {
+		compatible = "mediatek,mt8183-topckgen", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	infracfg: syscon at 10001000 {
+		compatible = "mediatek,mt8183-infracfg", "syscon";
+		reg = <0 0x10001000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	apmixedsys: syscon at 1000c000 {
+		compatible = "mediatek,mt8183-apmixedsys", "syscon";
+		reg = <0 0x1000c000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	audiosys: syscon at 11220000 {
+		compatible = "mediatek,mt8183-audiosys", "syscon";
+		reg = <0 0x11220000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mfgcfg: syscon at 13000000 {
+		compatible = "mediatek,mt8183-mfgcfg", "syscon";
+		reg = <0 0x13000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	mmsys: syscon at 14000000 {
+		compatible = "mediatek,mt8183-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	imgsys: syscon at 15020000 {
+		compatible = "mediatek,mt8183-imgsys", "syscon";
+		reg = <0 0x15020000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vdecsys: syscon at 16000000 {
+		compatible = "mediatek,mt8183-vdecsys", "syscon";
+		reg = <0 0x16000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	vencsys: syscon at 17000000 {
+		compatible = "mediatek,mt8183-vencsys", "syscon";
+		reg = <0 0x17000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_conn: syscon at 19000000 {
+		compatible = "mediatek,mt8183-ipu_conn", "syscon";
+		reg = <0 0x19000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_adl: syscon at 19010000 {
+		compatible = "mediatek,mt8183-ipu_adl", "syscon";
+		reg = <0 0x19010000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core0: syscon at 19180000 {
+		compatible = "mediatek,mt8183-ipu_core0", "syscon";
+		reg = <0 0x19180000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ipu_core1: syscon at 19280000 {
+		compatible = "mediatek,mt8183-ipu_core1", "syscon";
+		reg = <0 0x19280000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	camsys: syscon at 1a000000 {
+		compatible = "mediatek,mt8183-camsys", "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
1.9.1
