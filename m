From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Feb 2014 22:03:11 -0700
Subject: [PATCH 1/2] ARM: bcm2835: fix DT node sort order
Message-ID: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-order all the DT nodes so that they're ordered by their reg address.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 398eac3..5ceba45 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -60,14 +60,6 @@
 			reg = <0x7e104000 0x10>;
 		};
 
-		uart at 20201000 {
-			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
-			reg = <0x7e201000 0x1000>;
-			interrupts = <2 25>;
-			clock-frequency = <3000000>;
-			arm,primecell-periphid = <0x00241011>;
-		};
-
 		gpio: gpio {
 			compatible = "brcm,bcm2835-gpio";
 			reg = <0x7e200000 0xb4>;
@@ -91,6 +83,14 @@
 			#interrupt-cells = <2>;
 		};
 
+		uart at 20201000 {
+			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
+			reg = <0x7e201000 0x1000>;
+			interrupts = <2 25>;
+			clock-frequency = <3000000>;
+			arm,primecell-periphid = <0x00241011>;
+		};
+
 		i2s: i2s at 7e203000 {
 			compatible = "brcm,bcm2835-i2s";
 			reg = <0x7e203000 0x20>,
@@ -121,6 +121,14 @@
 			status = "disabled";
 		};
 
+		sdhci: sdhci {
+			compatible = "brcm,bcm2835-sdhci";
+			reg = <0x7e300000 0x100>;
+			interrupts = <2 30>;
+			clocks = <&clk_mmc>;
+			status = "disabled";
+		};
+
 		i2c1: i2c at 20804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
@@ -131,14 +139,6 @@
 			status = "disabled";
 		};
 
-		sdhci: sdhci {
-			compatible = "brcm,bcm2835-sdhci";
-			reg = <0x7e300000 0x100>;
-			interrupts = <2 30>;
-			clocks = <&clk_mmc>;
-			status = "disabled";
-		};
-
 		usb {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
-- 
1.8.3.2
