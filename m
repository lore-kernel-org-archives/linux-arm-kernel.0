From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  8 Jul 2015 15:15:07 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
Message-ID: <1436361307-27686-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enumerates the PL011 serial ports on the Ux500. This is
necessary to do if we want to remove one of the serial ports,
since userspace depends on console to be present on ttyAMA2
and we must not break userspace.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys: if you find this patch OK, please apply this
directly for fixes, as a prerequisite for patch 2/2.
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 853684ad7773..7db3650e05c4 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -15,6 +15,13 @@
 #include "skeleton.dtsi"
 
 / {
+	/* This stablilizes the serial port enumeration */
+	aliases {
+		serial0 = &ux500_serial0;
+		serial1 = &ux500_serial1;
+		serial2 = &ux500_serial2;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -971,7 +978,7 @@
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
-		uart at 80120000 {
+		ux500_serial0: uart at 80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
 			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -986,7 +993,7 @@
 			status = "disabled";
 		};
 
-		uart at 80121000 {
+		ux500_serial1: uart at 80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
 			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -1001,7 +1008,7 @@
 			status = "disabled";
 		};
 
-		uart at 80007000 {
+		ux500_serial2: uart at 80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
 			interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.4.3
