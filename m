From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 30 Jan 2015 13:13:15 +0800
Subject: [PATCH v4 4/7] dts: mediatek: Enable clock support for Mediatek
 MT8135.
In-Reply-To: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1422594798-13375-5-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds MT8135 clock controllers into device tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index ec83e69..f9b6a7d 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton64.dtsi"
@@ -92,6 +93,24 @@
 			clock-frequency = <26000000>;
 			#clock-cells = <0>;
 		};
+
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
+		rtc32k: rtc32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
 	};
 
 	soc {
@@ -100,6 +119,28 @@
 		compatible = "simple-bus";
 		ranges;
 
+		topckgen: topckgen at 10000000 {
+			compatible = "mediatek,mt8135-topckgen";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: infracfg at 10001000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: pericfg at 10003000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer",
 					"mediatek,mt6577-timer";
@@ -128,6 +169,12 @@
 			      <0 0x10216000 0 0x2000>;
 		};
 
+		apmixedsys: apmixedsys at 10209000 {
+			compatible = "mediatek,mt8135-apmixedsys";
+			reg = <0 0x10209000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial at 11006000 {
 			compatible = "mediatek,mt8135-uart","mediatek,mt6577-uart";
 			reg = <0 0x11006000 0 0x400>;
-- 
1.8.1.1.dirty
