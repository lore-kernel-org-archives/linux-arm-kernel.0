From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:40:29 -0600
Subject: [PATCH V2 5/5] ARM: remove #gpio-ranges-cells property
In-Reply-To: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1373913629-32179-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This property is no longer required by the GPIO binding. Remove it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This should presumably be applied along with the previous changes

v2: Squash spear and mxc changes into a single patch; there's no
need to keep vf610.dtsi separate now that this series will go into
v3.12 or later, and that file is part of v3.11-rc1.
---
 arch/arm/boot/dts/spear1310.dtsi | 1 -
 arch/arm/boot/dts/spear1340.dtsi | 1 -
 arch/arm/boot/dts/spear310.dtsi  | 1 -
 arch/arm/boot/dts/spear320.dtsi  | 2 --
 arch/arm/boot/dts/vf610.dtsi     | 1 -
 5 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 122ae94..90e99b5 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -89,7 +89,6 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1310-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <3>;
 		};
 
 		apb {
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 54d128d..5003013 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -63,7 +63,6 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1340-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <3>;
 		};
 
 		pwm: pwm at e0180000 {
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 9537208..1e1318e 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -25,7 +25,6 @@
 		pinmux: pinmux at b4000000 {
 			compatible = "st,spear310-pinmux";
 			reg = <0xb4000000 0x1000>;
-			#gpio-range-cells = <3>;
 		};
 
 		fsmc: flash at 44000000 {
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index ffea342..f630d0c 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -1,4 +1,3 @@
-/*
  * DTS file for SPEAr320 SoC
  *
  * Copyright 2012 Viresh Kumar <viresh.linux@gmail.com>
@@ -24,7 +23,6 @@
 		pinmux: pinmux at b3000000 {
 			compatible = "st,spear320-pinmux";
 			reg = <0xb3000000 0x1000>;
-			#gpio-range-cells = <3>;
 		};
 
 		clcd at 90000000 {
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e1eb7da..8577780 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -162,7 +162,6 @@
 			iomuxc: iomuxc at 40048000 {
 				compatible = "fsl,vf610-iomuxc";
 				reg = <0x40048000 0x1000>;
-				#gpio-range-cells = <3>;
 
 				/* functions and groups pins */
 
-- 
1.8.1.5
