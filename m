From: shawnguo@kernel.org (Shawn Guo)
Date: Fri,  4 May 2018 09:58:48 +0800
Subject: [RFC PATCH] ARM: dts: imx: replace underscore with hyphen in aliases
 name
Message-ID: <1525399128-11587-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It replaces underscore with hyphen in aliases name to fix DTC
alias_paths warning below, which is seen with various i.MX board dts
files when W=1 switch is on.

 Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Hi Lothar, Gary,

Per my search on kernel code, this change will not break anything on
kernel support.  But I'm not really sure about the case of bootloaders
running on the boards.  That's why I'm sending it as RFC.

We really want i.MX to be the first-class citizen in the community.
After a few cycles efforts on cleaning up DTC warnings, this alias_paths
warning is the last one we see with i.MX dts files.  We really want to
get rid of it and make i.MX dts be DTC warning free.

So please comment whether we can merge this patch.

Shawn

 arch/arm/boot/dts/imx53-tx53.dtsi            | 2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           | 6 +++---
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts     | 4 ++--
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts | 2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi          | 6 +++---
 arch/arm/boot/dts/imx7d-nitrogen7.dts        | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 5dd3dd3a2fd0..54cf3e67069a 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -58,7 +58,7 @@
 		can0 = &can2; /* Make the can interface indices consistent with TX28/TX48 modules */
 		can1 = &can1;
 		ipu = &ipu;
-		reg_can_xcvr = &reg_can_xcvr;
+		reg-can-xcvr = &reg_can_xcvr;
 		usbh1 = &usbh1;
 		usbotg = &usbotg;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f015e2d1cf35..a98fb2564c63 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -50,11 +50,11 @@
 		can0 = &can2;
 		can1 = &can1;
 		ethernet0 = &fec;
-		lcdif_23bit_pins_a = &pinctrl_disp0_1;
-		lcdif_24bit_pins_a = &pinctrl_disp0_2;
+		lcdif-23bit-pins-a = &pinctrl_disp0_1;
+		lcdif-24bit-pins-a = &pinctrl_disp0_2;
 		pwm0 = &pwm1;
 		pwm1 = &pwm2;
-		reg_can_xcvr = &reg_can_xcvr;
+		reg-can-xcvr = &reg_can_xcvr;
 		stk5led = &user_led;
 		usbotg = &usbotg;
 		sdhc0 = &usdhc1;
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index b58f770c40d9..59e52f504922 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -48,8 +48,8 @@
 	compatible = "boundary,imx6sx-nitrogen6sx", "fsl,imx6sx";
 
 	aliases {
-		fb_lcd = &lcdif1;
-		t_lcd = &t_lcd;
+		fb-lcd = &lcdif1;
+		t-lcd = &t_lcd;
 	};
 
 	memory at 80000000 {
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
index 2d80f7b50bc0..97686097a86e 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
+++ b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
@@ -48,7 +48,7 @@
 	compatible = "karo,imx6ul-tx6ul", "fsl,imx6ul";
 
 	aliases {
-		lcdif_24bit_pins_a = &pinctrl_disp0_3;
+		lcdif-24bit-pins-a = &pinctrl_disp0_3;
 		mmc0 = &usdhc1;
 		/delete-property/ mmc1;
 		serial2 = &uart3;
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index f678d18ad44a..02b5ba42cd59 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -53,10 +53,10 @@
 		i2c2 = &i2c1;
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
-		lcdif_23bit_pins_a = &pinctrl_disp0_1;
-		lcdif_24bit_pins_a = &pinctrl_disp0_2;
+		lcdif-23bit-pins-a = &pinctrl_disp0_1;
+		lcdif-24bit-pins-a = &pinctrl_disp0_2;
 		pwm0 = &pwm5;
-		reg_can_xcvr = &reg_can_xcvr;
+		reg-can-xcvr = &reg_can_xcvr;
 		serial2 = &uart5;
 		serial4 = &uart3;
 		spi0 = &ecspi2;
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 52167298984d..b8e73b46cddb 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -49,8 +49,8 @@
 	compatible = "boundary,imx7d-nitrogen7", "fsl,imx7d";
 
 	aliases {
-		fb_lcd = &lcdif;
-		t_lcd = &t_lcd;
+		fb-lcd = &lcdif;
+		t-lcd = &t_lcd;
 	};
 
 	memory at 80000000 {
-- 
1.9.1
