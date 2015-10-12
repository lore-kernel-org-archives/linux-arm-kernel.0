From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:47 +0300
Subject: [PATCH 18/37] ARM: dts: imx28-evk: Fix regulator enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-19-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 279249b8c3f3..17598d3bb408 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -295,7 +295,7 @@
 			regulator-name = "vddio-sd0";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 28 0>;
+			gpio = <&gpio3 28 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_fec_3v3: regulator at 2 {
@@ -304,7 +304,7 @@
 			regulator-name = "fec-3v3";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 15 0>;
+			gpio = <&gpio2 15 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_usb0_vbus: regulator at 3 {
-- 
2.4.9
