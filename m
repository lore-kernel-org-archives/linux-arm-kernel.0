From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:55 +0300
Subject: [PATCH 26/37] ARM: dts: imx6q-dmo-edmqmx6: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-27-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 4fa254347798..3272d8048ace 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -53,7 +53,7 @@
 			regulator-name = "usb_otg_switch";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio7 12 0>;
+			gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
2.4.9
