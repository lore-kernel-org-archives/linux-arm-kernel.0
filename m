From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 27 Jun 2016 09:14:02 -0500
Subject: [PATCH] ARM: dts: da850: Add new ECAP and EPWM bindings
Message-ID: <1467036842-20913-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Cooper Jr., Franklin" <fcooper@ti.com>

Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
provide the various required clocks.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---

This patch is a da850 specific version of:
ARM: dts: am437x/am33xx/da850: Add new ECAP and EPWM bindings
https://patchwork.kernel.org/patch/9005661/

This patch was created since the da850 portion didn't apply cleanly in
the original patch.

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
