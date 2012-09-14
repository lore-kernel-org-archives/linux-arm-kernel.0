From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 22:41:24 -0600
Subject: [PATCH V4 5/5] ARM: bcm2835: instantiate console UART
In-Reply-To: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347597684-30805-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Arlott <simon@fire.lp0.eu>

This patch was extracted from git://github.com/lp0/linux.git branch
rpi-split as of 2012/09/08, and modified as follows:

* s/bcm2708/bcm2835/.
* Modified device tree vendor prefix.
* Modified UART DT node to use a unit-address to create unique UART node
  names, rather than using non-type names "uart0" and "uart1".
  Note that UART 1 (the Broadcom "mini UART") is not yet present, but
  I'm naming the DT node in anticipation that it will be added.

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <dc4@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
--
v4:
* s/bcm2708/bcm2835/.
* Updated for new device tree vendor prefix.
v3:
* New patch.
---
 arch/arm/boot/dts/bcm2835.dtsi |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index c7ac399..e837780 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -6,7 +6,7 @@
 	interrupt-parent = <&intc>;
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlyprintk console=ttyAMA0";
 	};
 
 	timer {
@@ -22,4 +22,11 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	uart at 20201000 {
+		compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
+		reg = <0x20201000 0x1000>;
+		interrupts = <2 25>;
+		clock-frequency = <3000000>;
+	};
 };
-- 
1.7.9.5
