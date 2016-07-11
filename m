From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 11 Jul 2016 14:11:46 -0500
Subject: [PATCH v2] ARM: dts: da850: Add new ECAP and EPWM bindings
Message-ID: <1468264306-3806-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Cooper Jr., Franklin" <fcooper@ti.com>

For some devices, the PWMSS is a parent of eCAP and ePWM and provided the
functional clocks for those submodules. The ti,am33xx-ecap and
ti,am33xx-ehrpwm were based on this parent child relationship where the
functional clock would be grabbed from the module's parent.

However, DA850 doesn't have a PWMSS and the eCAP and ePWM provides their
functional clock themselves. Therefore, prefer the new binding that doesn't
assume this parent child relationship.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2 changes:
Fix commit message

This patch handles the da850 portion that wouldn't apply from the
following patch that has been accepted:
https://patchwork.kernel.org/patch/9005661/


 arch/arm/boot/dts/da850.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 25f0f8e..09cf663 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -274,31 +274,36 @@
 			status = "disabled";
 		};
 		ehrpwm0: pwm at 300000 {
-			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
+				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			status = "disabled";
 		};
 		ehrpwm1: pwm at 302000 {
-			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
+				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
 			status = "disabled";
 		};
 		ecap0: ecap at 306000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
 			status = "disabled";
 		};
 		ecap1: ecap at 307000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
 			status = "disabled";
 		};
 		ecap2: ecap at 308000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
 			status = "disabled";
-- 
2.7.0
