From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:51 +0300
Subject: [PATCH 22/37] ARM: dts: imx28-tx28: Fix regulator enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-23-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx28-tx28.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index a5b27c85a91c..480c5ecaea2d 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -93,7 +93,7 @@
 			regulator-name = "CAN XCVR";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
 		};
-- 
2.4.9
