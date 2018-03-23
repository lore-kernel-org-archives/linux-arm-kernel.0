From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 23 Mar 2018 22:38:15 +0800
Subject: [PATCH v2 6/7] arm64: dts: meson-axg: add AO clock driver DT info
In-Reply-To: <20180323143816.200573-1-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
Message-ID: <20180323143816.200573-7-yixun.lan@amlogic.com>
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
index a80632641b39..b3d394f5d95a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/axg-clkc.h>
+#include <dt-bindings/clock/axg-aoclkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -472,6 +473,17 @@
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
