From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 13:18:25 +0300
Subject: [PATCH v2 5/9] ARM: dts: omap3-beagle: Use reset-gpios for
 hsusb2_reset
In-Reply-To: <1376561909-4406-1-git-send-email-rogerq@ti.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Message-ID: <1376561909-4406-6-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer need to model the RESET line as a regulator since
the USB phy-nop driver accepts "reset-gpios" property.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index dfd8310..71bde47 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -44,17 +44,6 @@
 		};
 	};
 
-	/* HS USB Port 2 RESET */
-	hsusb2_reset: hsusb2_reset_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb2_reset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 19 0>;	/* gpio_147 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
 	/* HS USB Port 2 Power */
 	hsusb2_power: hsusb2_power_reg {
 		compatible = "regulator-fixed";
@@ -68,7 +57,7 @@
 	/* HS USB Host PHY on PORT 2 */
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
-		reset-supply = <&hsusb2_reset>;
+		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>;	/* gpio_147 */
 		vcc-supply = <&hsusb2_power>;
 	};
 
-- 
1.7.4.1
