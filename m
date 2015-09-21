From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:46 -0700
Subject: [PATCH v3 5/9] ARM: dts: Reorder Cygnus peripherals
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-6-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder all Cygnus peripherals based on base register addresses in
bcm-cygnus.dtsi

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 5ee7543..33ec6a5 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -108,26 +108,14 @@
 			gpio-controller;
 		};
 
-		gpio_ccm: gpio at 1800a000 {
-			compatible = "brcm,cygnus-ccm-gpio";
-			reg = <0x1800a000 0x50>,
-			      <0x0301d164 0x20>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-		};
-
-		gpio_asiu: gpio at 180a5000 {
-			compatible = "brcm,cygnus-asiu-gpio";
-			reg = <0x180a5000 0x668>;
-			#gpio-cells = <2>;
-			gpio-controller;
-
-			pinmux = <&pinctrl>;
-
-			interrupt-controller;
-			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		i2c0: i2c at 18008000 {
+			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+			reg = <0x18008000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
 		};
 
 		wdt0: wdt at 18009000 {
@@ -138,14 +126,14 @@
 			clock-names = "apb_pclk";
 		};
 
-		i2c0: i2c at 18008000 {
-			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
-			reg = <0x18008000 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
-			clock-frequency = <100000>;
-			status = "disabled";
+		gpio_ccm: gpio at 1800a000 {
+			compatible = "brcm,cygnus-ccm-gpio";
+			reg = <0x1800a000 0x50>,
+			      <0x0301d164 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
 		};
 
 		i2c1: i2c at 1800b000 {
@@ -257,5 +245,17 @@
 
 			brcm,nand-has-wp;
 		};
+
+		gpio_asiu: gpio at 180a5000 {
+			compatible = "brcm,cygnus-asiu-gpio";
+			reg = <0x180a5000 0x668>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			pinmux = <&pinctrl>;
+
+			interrupt-controller;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
1.9.1
