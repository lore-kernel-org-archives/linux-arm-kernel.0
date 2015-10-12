From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:40 +0300
Subject: [PATCH 11/37] ARM: dts: dove-cm-a510: Fix regulator enable GPIO
 polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-12-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/dove-cm-a510.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove-cm-a510.dtsi
index 59b4056b478f..d5d84a61437f 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dtsi
+++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
@@ -118,7 +118,7 @@
 			regulator-name = "WiFi Power";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.4.9
