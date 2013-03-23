From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 23 Mar 2013 18:13:51 +1300
Subject: [PATCHv2 5/7] arm: vt8500: Remove gpio devicetree nodes
In-Reply-To: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1364015633-18580-6-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the gpio related devicetree nodes as these are no longer required
with the move to a combined pinctrl/gpio driver.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500.dtsi |    7 -------
 arch/arm/boot/dts/wm8505.dtsi |    7 -------
 arch/arm/boot/dts/wm8650.dtsi |    7 -------
 arch/arm/boot/dts/wm8850.dtsi |    7 -------
 4 files changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index 16388c2..e0ce0b9 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -25,13 +25,6 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio: gpio-controller at d8110000 {
-			compatible = "via,vt8500-gpio";
-			gpio-controller;
-			reg = <0xd8110000 0x10000>;
-			#gpio-cells = <3>;
-		};
-
 		pinctrl: pinctrl at d8110000 {
 			compatible = "via,vt8500-pinctrl";
 			gpio-controller;
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index c5aa4c9..5c7ad12 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -40,13 +40,6 @@
 			interrupts = <56 57 58 59 60 61 62 63>;
 		};
 
-		gpio: gpio-controller at d8110000 {
-			compatible = "wm,wm8505-gpio";
-			gpio-controller;
-			reg = <0xd8110000 0x10000>;
-			#gpio-cells = <3>;
-		};
-
 		pinctrl: pinctrl at d8110000 {
 			compatible = "wm,wm8505-pinctrl";
 			gpio-controller;
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index 99c45e5..984d0ed 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -34,13 +34,6 @@
 			interrupts = <56 57 58 59 60 61 62 63>;
 		};
 
-		gpio: gpio-controller at d8110000 {
-			compatible = "wm,wm8650-gpio";
-			gpio-controller;
-			reg = <0xd8110000 0x10000>;
-			#gpio-cells = <3>;
-		};
-
 		pinctrl: pinctrl at d8110000 {
 			compatible = "wm,wm8650-pinctrl";
 			gpio-controller;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index 60094cd..01d67bf 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -41,13 +41,6 @@
 			interrupts = <56 57 58 59 60 61 62 63>;
 		};
 
-		gpio: gpio-controller at d8110000 {
-			compatible = "wm,wm8650-gpio";
-			gpio-controller;
-			reg = <0xd8110000 0x10000>;
-			#gpio-cells = <3>;
-		};
-
 		pinctrl: pinctrl at d8110000 {
 			compatible = "wm,wm8850-pinctrl";
 			gpio-controller;
-- 
1.7.9.5
