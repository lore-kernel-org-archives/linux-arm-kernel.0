From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu, 17 Mar 2016 20:15:22 -0500
Subject: [PATCH v3 2/3] ARM: DTS: da850/am4372/am33xx: Use generic node name
 for ehrpwm
In-Reply-To: <1458263723-25770-1-git-send-email-fcooper@ti.com>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
Message-ID: <1458263723-25770-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When possible generic node names should be used. So change the node name
from ehrpwm to pwm.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 3 changes:
Also update am335x-shc.dts

 arch/arm/boot/dts/am335x-shc.dts |  2 +-
 arch/arm/boot/dts/am33xx.dtsi    |  6 +++---
 arch/arm/boot/dts/am4372.dtsi    | 12 ++++++------
 arch/arm/boot/dts/da850.dtsi     |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 1b5b044..a10f8be 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -138,7 +138,7 @@
 &epwmss1 {
 	status = "okay";
 
-	ehrpwm1: ehrpwm at 48302200 {
+	ehrpwm1: pwm at 48302200 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ehrpwm1_pins>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1fafaad..4016254 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -688,7 +688,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm0: ehrpwm at 48300200 {
+			ehrpwm0: pwm at 48300200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
@@ -718,7 +718,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm1: ehrpwm at 48302200 {
+			ehrpwm1: pwm at 48302200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
@@ -748,7 +748,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm2: ehrpwm at 48304200 {
+			ehrpwm2: pwm at 48304200 {
 				compatible = "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 92068fb..33f417c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -679,7 +679,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm0: ehrpwm at 48300200 {
+			ehrpwm0: pwm at 48300200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
@@ -705,7 +705,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm1: ehrpwm at 48302200 {
+			ehrpwm1: pwm at 48302200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
@@ -731,7 +731,7 @@
 				status = "disabled";
 			};
 
-			ehrpwm2: ehrpwm at 48304200 {
+			ehrpwm2: pwm at 48304200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
@@ -749,7 +749,7 @@
 			ti,hwmods = "epwmss3";
 			status = "disabled";
 
-			ehrpwm3: ehrpwm at 48306200 {
+			ehrpwm3: pwm at 48306200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
@@ -767,7 +767,7 @@
 			ti,hwmods = "epwmss4";
 			status = "disabled";
 
-			ehrpwm4: ehrpwm at 48308200 {
+			ehrpwm4: pwm at 48308200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
@@ -785,7 +785,7 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 
-			ehrpwm5: ehrpwm at 4830a200 {
+			ehrpwm5: pwm at 4830a200 {
 				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 226cda7..c3910e2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -247,13 +247,13 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-		ehrpwm0: ehrpwm at 01f00000 {
+		ehrpwm0: pwm at 01f00000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			status = "disabled";
 		};
-		ehrpwm1: ehrpwm at 01f02000 {
+		ehrpwm1: pwm at 01f02000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
-- 
2.7.0
