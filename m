From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 28 Mar 2018 11:01:28 +0800
Subject: [PATCH v3 1/3] arm64: dts: meson-axg: add AO clock driver DT info
In-Reply-To: <20180328030130.240336-1-yixun.lan@amlogic.com>
References: <20180328030130.240336-1-yixun.lan@amlogic.com>
Message-ID: <20180328030130.240336-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qiufang Dai <qiufang.dai@amlogic.com>

This add the AO (Always-On part) clock DT info for Meson-AXG SoC

Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..b0eff7d7f771 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/axg-clkc.h>
+#include <dt-bindings/clock/axg-aoclkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -688,6 +689,17 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			sysctrl_AO: sys-ctrl at 0 {
+				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
+				reg =  <0x0 0x0 0x0 0x100>;
+
+				clkc_AO: clock-controller {
+					compatible = "amlogic,meson-axg-aoclkc";
+					#clock-cells = <1>;
+					#reset-cells = <1>;
+				};
+			};
+
 			pinctrl_aobus: pinctrl at 14 {
 				compatible = "amlogic,meson-axg-aobus-pinctrl";
 				#address-cells = <2>;
-- 
2.15.1
