From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:39 +0300
Subject: [PATCH 10/37] ARM: dts: imx6qdl-tx6: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-11-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

While at it remove the enable-active-low property as it isn't part of
the regulator-fixed DT bindings and isn't used by the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index da08de324e9e..8d472ae3e8ae 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -108,8 +108,7 @@
 			regulator-max-microvolt = <3300000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_flexcan_xcvr>;
-			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
-			enable-active-low;
+			gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_lcd0_pwr: regulator at 4 {
-- 
2.4.9
