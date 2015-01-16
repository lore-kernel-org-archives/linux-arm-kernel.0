From: stefan@agner.ch (Stefan Agner)
Date: Fri, 16 Jan 2015 18:06:15 +0100
Subject: [PATCH] ARM: vf610: use zero based naming for GPIO nodes
Message-ID: <1421427975-16391-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Vybrid, all peripherals are numbered starting with zero,
including the GPIO and PORT module. However, the labels of the
corresponding device tree nodes start with one, which is confusing.
Fix that by renaming the labels of the gpio nodes in the device
tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
We do not have a lot of GPIO usage up until now, so better fix
this early...

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |  2 +-
 arch/arm/boot/dts/vf-colibri.dtsi         |  2 +-
 arch/arm/boot/dts/vf500.dtsi              | 10 +++++-----
 arch/arm/boot/dts/vf610-twr.dts           |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi              | 20 ++++++++++----------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 56a452b..36cafbf 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -35,7 +35,7 @@
 			regulator-name = "usbh_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+			gpio = <&gpio2 19 GPIO_ACTIVE_LOW>;
 			vin-supply = <&sys_5v0_reg>;
 		};
 	};
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 95b6ff2..5c2b732 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -31,7 +31,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
-	cd-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 };
 
 &fec1 {
diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 2901609..68bd231 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -94,23 +94,23 @@
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&gpio1 {
+&gpio0 {
 	interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&gpio2 {
+&gpio1 {
 	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&gpio3 {
+&gpio2 {
 	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&gpio4 {
+&gpio3 {
 	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&gpio5 {
+&gpio4 {
 	interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 };
 
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index a0f7621..289fef2 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -123,7 +123,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
-	cd-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a55e1f9..d19f1ee 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -22,11 +22,11 @@
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		gpio4 = &gpio5;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
 		usbphy0 = &usbphy0;
 		usbphy1 = &usbphy1;
 	};
@@ -216,7 +216,7 @@
 				#gpio-range-cells = <3>;
 			};
 
-			gpio1: gpio at 40049000 {
+			gpio0: gpio at 40049000 {
 				compatible = "fsl,vf610-gpio";
 				reg = <0x40049000 0x1000 0x400ff000 0x40>;
 				gpio-controller;
@@ -226,7 +226,7 @@
 				gpio-ranges = <&iomuxc 0 0 32>;
 			};
 
-			gpio2: gpio at 4004a000 {
+			gpio1: gpio at 4004a000 {
 				compatible = "fsl,vf610-gpio";
 				reg = <0x4004a000 0x1000 0x400ff040 0x40>;
 				gpio-controller;
@@ -236,7 +236,7 @@
 				gpio-ranges = <&iomuxc 0 32 32>;
 			};
 
-			gpio3: gpio at 4004b000 {
+			gpio2: gpio at 4004b000 {
 				compatible = "fsl,vf610-gpio";
 				reg = <0x4004b000 0x1000 0x400ff080 0x40>;
 				gpio-controller;
@@ -246,7 +246,7 @@
 				gpio-ranges = <&iomuxc 0 64 32>;
 			};
 
-			gpio4: gpio at 4004c000 {
+			gpio3: gpio at 4004c000 {
 				compatible = "fsl,vf610-gpio";
 				reg = <0x4004c000 0x1000 0x400ff0c0 0x40>;
 				gpio-controller;
@@ -256,7 +256,7 @@
 				gpio-ranges = <&iomuxc 0 96 32>;
 			};
 
-			gpio5: gpio at 4004d000 {
+			gpio4: gpio at 4004d000 {
 				compatible = "fsl,vf610-gpio";
 				reg = <0x4004d000 0x1000 0x400ff100 0x40>;
 				gpio-controller;
-- 
2.2.2
