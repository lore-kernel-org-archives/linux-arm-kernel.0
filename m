From: akurz@blala.de (Alexander Kurz)
Date: Sun, 24 Jun 2018 06:15:38 +0000
Subject: [PATCH] ARM: dts: imx50: remove non-existent USB instances
Message-ID: <20180624061538.10156-1-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the i.MX50 Reference Manual, the SoC features one USB OTG
and one host controller. Remove the non-existent instances from the
DTS which probably got initially copied from the mx53 DTS.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx50-evk.dts |  8 --------
 arch/arm/boot/dts/imx50.dtsi    | 18 ------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 98b5faa06e27..d952bd150764 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -105,14 +105,6 @@
 	status = "okay";
 };
 
-&usbh2 {
-	status = "okay";
-};
-
-&usbh3 {
-	status = "okay";
-};
-
 &usbotg {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 3747d80104f4..42b3e53e07e9 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -212,24 +212,6 @@
 				status = "disabled";
 			};
 
-			usbh2: usb at 53f80400 {
-				compatible = "fsl,imx50-usb", "fsl,imx27-usb";
-				reg = <0x53f80400 0x0200>;
-				interrupts = <16>;
-				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
-				dr_mode = "host";
-				status = "disabled";
-			};
-
-			usbh3: usb at 53f80600 {
-				compatible = "fsl,imx50-usb", "fsl,imx27-usb";
-				reg = <0x53f80600 0x0200>;
-				interrupts = <17>;
-				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
-				dr_mode = "host";
-				status = "disabled";
-			};
-
 			gpio1: gpio at 53f84000 {
 				compatible = "fsl,imx50-gpio", "fsl,imx35-gpio";
 				reg = <0x53f84000 0x4000>;
-- 
2.11.0
