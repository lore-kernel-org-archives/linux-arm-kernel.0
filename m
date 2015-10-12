From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:54 +0300
Subject: [PATCH 25/37] ARM: dts: imx53-tx53: Fix regulator enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-26-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx53-tx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index d3e50b22064f..62a324961ec8 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -95,7 +95,7 @@
 			regulator-max-microvolt = <3300000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_can_xcvr>;
-			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_usbh1_vbus: regulator at 3 {
-- 
2.4.9
