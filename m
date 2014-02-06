From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 10:40:32 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new clocksource
 compatible
In-Reply-To: <1391679632-15139-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391679632-15139-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391679632-15139-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the timer driver
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 28273f9..d7cbc3a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -409,7 +409,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-timer";
+			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2318082..ecbf5e3 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -370,7 +370,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-timer";
+			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 6de40b6..bed2479 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -334,7 +334,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-timer";
+			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 092bf97..de2aa91 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -241,7 +241,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-timer";
+			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <0 18 4>,
 				     <0 19 4>,
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bfb2cf2..a725cee 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -450,7 +450,7 @@
 		};
 
 		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-timer";
+			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <0 22 4>,
 				     <0 23 4>,
-- 
1.8.4.2
