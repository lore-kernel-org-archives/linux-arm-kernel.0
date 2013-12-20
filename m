From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 22:53:07 +0100
Subject: [PATCH 2/2] ARM: sun4i: dt: Remove chosen nodes
In-Reply-To: <1387576387-22122-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1387576387-22122-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1387576387-22122-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chosen nodes are nowadays pretty useless, since they will be overriden by
the bootloader anyway.

We can thus safely remove them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 4 ----
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  | 4 ----
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 4 ----
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  | 4 ----
 4 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index f1c77e0..b139ee6 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -17,10 +17,6 @@
 	model = "Cubietech Cubieboard";
 	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
 
-	chosen {
-		bootargs = "earlyprintk console=ttyS0,115200";
-	};
-
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index b3ae51f..3a1595f 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -18,10 +18,6 @@
 	model = "Miniand Hackberry";
 	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
 
-	chosen {
-		bootargs = "earlyprintk console=ttyS0,115200";
-	};
-
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 0c1447c..70b3323 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -18,10 +18,6 @@
 	model = "PineRiver Mini X-Plus";
 	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
 
-	chosen {
-		bootargs = "earlyprintk console=ttyS0,115200";
-	};
-
 	soc at 01c00000 {
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 9e508dc..a4ba5ff 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -18,10 +18,6 @@
 	model = "Olimex A13-Olinuxino";
 	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
-	chosen {
-		bootargs = "earlyprintk console=ttyS0,115200";
-	};
-
 	soc at 01c00000 {
 		pinctrl at 01c20800 {
 			led_pins_olinuxino: led_pins at 0 {
-- 
1.8.4.2
