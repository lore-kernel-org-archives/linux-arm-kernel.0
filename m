From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:48 +0300
Subject: [PATCH 19/37] ARM: dts: imx28-m28cu3: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-20-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx28-m28cu3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 2df63bee6f4e..026a17e05dc9 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -246,7 +246,7 @@
 			regulator-name = "vddio-sd0";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 29 0>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_vddio_sd1: regulator at 2 {
@@ -255,7 +255,7 @@
 			regulator-name = "vddio-sd1";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 19 0>;
+			gpio = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_usb1_vbus: regulator at 3 {
-- 
2.4.9
