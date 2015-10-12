From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:50 +0300
Subject: [PATCH 21/37] ARM: dts: imx28-sps1: Fix regulator enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-22-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx28-sps1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 0ce3cb8e7914..d68886646941 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -136,7 +136,7 @@
 			regulator-name = "usb0_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 9 0>;
+			gpio = <&gpio3 9 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.4.9
