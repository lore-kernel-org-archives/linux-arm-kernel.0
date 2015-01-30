From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 30 Jan 2015 13:13:18 +0800
Subject: [PATCH v4 7/7] dts: mediatek: Enable clock support for Mediatek
 MT8173.
In-Reply-To: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1422594798-13375-8-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds MT8173 clock controllers into device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 41c1441..31ccad3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -11,6 +11,8 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8173-clk.h>
+
 / {
 	compatible = "mediatek,mt8173";
 	interrupt-parent = <&sysirq>;
@@ -78,6 +80,26 @@
 		affinity_info = <0x84000004>;
 	};
 
+	clocks {
+		clk_null: clk_null {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		clk26m: clk26m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+
+		clk32k: clk32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
 	uart_clk: dummy26m {
 		compatible = "fixed-clock";
 		clock-frequency = <26000000>;
@@ -99,6 +121,24 @@
 		compatible = "simple-bus";
 		ranges;
 
+		topckgen: topckgen at 10000000 {
+			compatible = "mediatek,mt8173-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: infracfg at 10001000 {
+			compatible = "mediatek,mt8173-infracfg";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: pericfg at 10003000 {
+			compatible = "mediatek,mt8173-pericfg";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq";
 			interrupt-controller;
@@ -107,6 +147,12 @@
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		apmixedsys: apmixedsys at 10209000 {
+			compatible = "mediatek,mt8173-apmixedsys";
+			reg = <0 0x10209000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		gic: interrupt-controller at 10220000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
1.8.1.1.dirty
