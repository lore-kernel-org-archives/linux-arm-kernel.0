From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon,  7 Mar 2016 13:51:56 -0600
Subject: [PATCH 3/5] ARM: DTS: am33xx: Set pwmss ranges property to an empty
 value
In-Reply-To: <1457380318-15452-1-git-send-email-fcooper@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
Message-ID: <1457380318-15452-4-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eCAP and ePWM are in the same address space as the PWMSS. Therefore,
no address translation is needed which means the ranges property should be
empty.

This mimics how the PWMSS nodes look in the AM4372.dtsi which is similar
to AM335x.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4016254..82c0976 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -674,9 +674,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-				  0x48300180 0x48300180 0x80   /* EQEP */
-				  0x48300200 0x48300200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap0: ecap at 48300100 {
 				compatible = "ti,am33xx-ecap";
@@ -704,9 +702,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48302100 0x48302100 0x80   /* ECAP */
-				  0x48302180 0x48302180 0x80   /* EQEP */
-				  0x48302200 0x48302200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap1: ecap at 48302100 {
 				compatible = "ti,am33xx-ecap";
@@ -734,9 +730,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
-			ranges = <0x48304100 0x48304100 0x80   /* ECAP */
-				  0x48304180 0x48304180 0x80   /* EQEP */
-				  0x48304200 0x48304200 0x80>; /* EHRPWM */
+			ranges;
 
 			ecap2: ecap at 48304100 {
 				compatible = "ti,am33xx-ecap";
-- 
2.7.0
