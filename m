From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:41 +0300
Subject: [PATCH 12/37] ARM: dts: dove-sbc-a510: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-13-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/dove-sbc-a510.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts b/arch/arm/boot/dts/dove-sbc-a510.dts
index 288e707dea99..3bc5c96483be 100644
--- a/arch/arm/boot/dts/dove-sbc-a510.dts
+++ b/arch/arm/boot/dts/dove-sbc-a510.dts
@@ -82,7 +82,7 @@
 			regulator-name = "USB Power";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio_ext 0 GPIO_ACTIVE_LOW>;
 		};
 
 		mmc_power: regulator at 3 {
@@ -90,7 +90,7 @@
 			regulator-name = "MMC Power";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio_ext 13 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.4.9
