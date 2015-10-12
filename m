From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:49 +0300
Subject: [PATCH 20/37] ARM: dts: imx28-m28evk: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-21-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/imx28-m28evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index e35cc6ba3ca6..c34cc49cfe42 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -243,7 +243,7 @@
 			regulator-name = "vddio-sd0";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 28 0>;
+			gpio = <&gpio3 28 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_usb0_vbus: regulator at 2 {
@@ -252,7 +252,7 @@
 			regulator-name = "usb0_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 12 0>;
+			gpio = <&gpio3 12 GPIO_ACTIVE_LOW>;
 		};
 
 		reg_usb1_vbus: regulator at 3 {
@@ -261,7 +261,7 @@
 			regulator-name = "usb1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 13 0>;
+			gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.4.9
