From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:34:00 +0200
Subject: [PATCH 2/6] ARM: sun4i: dt: Fix A10 SoC bus base address
In-Reply-To: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375608844-13159-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a typo in the base address used for the soc node in the A10
device tree. Fix it with the proper base address.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  | 2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 4580b62..425a7db 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -26,7 +26,7 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc at 01c20000 {
+	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&emac_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 3514b37..b3ae51f 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -22,7 +22,7 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc at 01c20000 {
+	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&emac_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 078ed7f..0c1447c 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -22,7 +22,7 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc at 01c20000 {
+	soc at 01c00000 {
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3ed2e1e..c32770a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -160,7 +160,7 @@
 		};
 	};
 
-	soc at 01c20000 {
+	soc at 01c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.3.4
