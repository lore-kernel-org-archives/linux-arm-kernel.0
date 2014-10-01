From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed,  1 Oct 2014 15:45:28 +0200
Subject: [PATCH 1/2] ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file
Message-ID: <1412171129-31482-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been successfully tested on Netgear R6250 and two other
development (unnamed) devices, all of them BCM4708 based.
We also got a possitive feedback from R7000 (BCM4709) tester.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
Support for "brcm,bus-axi" has been added in
bcma: register bcma as device tree driver
---
 arch/arm/boot/dts/bcm5301x.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 53c624f..6d80922 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -8,6 +8,7 @@
  * Licensed under the GNU/GPL. See COPYING for details.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "skeleton.dtsi"
@@ -92,4 +93,19 @@
 			clock-frequency = <400000000>;
 		};
 	};
+
+	axi at 18000000 {
+		compatible = "brcm,bus-axi";
+		reg = <0x18000000 0x1000>;
+		ranges = <0x00000000 0x18000000 0x00100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		chipcommon: chipcommon at 0 {
+			reg = <0x00000000 0x1000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
 };
-- 
1.8.4.5
