From: csd@broadcom.com (Christian Daudt)
Date: Thu, 8 Aug 2013 12:07:53 -0700
Subject: [PATCH 1/2] ARM: dts: align sdio numbers to HW definition
Message-ID: <1375988874-11303-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the sdio numbering to be 1-base as defined in HW spec,
instead of the current 0-base

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 67ec524..647a78c 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -27,18 +27,18 @@
 		status = "okay";
 	};
 
-	sdio0: sdio at 0x3f180000 {
+	sdio1: sdio at 3f180000 {
 		max-frequency = <48000000>;
 		status = "okay";
 	};
 
-	sdio1: sdio at 0x3f190000 {
+	sdio2: sdio at 3f190000 {
 		non-removable;
 		max-frequency = <48000000>;
 		status = "okay";
 	};
 
-	sdio3: sdio at 0x3f1b0000 {
+	sdio4: sdio at 3f1b0000 {
 		max-frequency = <48000000>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 8f094ba..d34e49db 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -68,28 +68,28 @@
 		clock-frequency = <32768>;
 	};
 
-	sdio0: sdio at 0x3f180000 {
+	sdio1: sdio at 3f180000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
 		interrupts = <0x0 77 0x4>;
 		status = "disabled";
 	};
 
-	sdio1: sdio at 0x3f190000 {
+	sdio2: sdio at 3f190000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
 		interrupts = <0x0 76 0x4>;
 		status = "disabled";
 	};
 
-	sdio2: sdio at 0x3f1a0000 {
+	sdio3: sdio at 3f1a0000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
 		interrupts = <0x0 74 0x4>;
 		status = "disabled";
 	};
 
-	sdio3: sdio at 0x3f1b0000 {
+	sdio4: sdio at 3f1b0000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <0x0 73 0x4>;
-- 
1.7.10.4
