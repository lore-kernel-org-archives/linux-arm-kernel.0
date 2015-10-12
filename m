From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:13:01 +0300
Subject: [PATCH 32/37] ARM: dts: omap3-overo-base: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-33-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: linux-omap at vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 18e1649681c1..1fa59d0e1e8a 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -65,7 +65,7 @@
 		regulator-name = "regulator-w3cbw003c-wifi-nreset";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;		/* gpio_16: WiFi nReset */
+		gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;		/* gpio_16: WiFi nReset */
 		startup-delay-us = <10000>;
 	};
 
@@ -75,7 +75,7 @@
 		regulator-name = "regulator-w3cbw003c-bt-nreset";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;		/* gpio_164: BT nReset */
+		gpio = <&gpio6 4 GPIO_ACTIVE_LOW>;		/* gpio_164: BT nReset */
 		startup-delay-us = <10000>;
 	};
 };
-- 
2.4.9
