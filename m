From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:56 +0300
Subject: [PATCH 27/37] ARM: dts: kirkwood-blackarmor-nas220: Fix regulator
 enable GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-28-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIOs are active high, but are flagged as active low in the
gpio properties. As the gpio property flags are currently unused by the
driver this doesn't cause any issue for now, but will break later if the
driver starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts b/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
index fa02a9aff05e..8d155295d528 100644
--- a/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
+++ b/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
@@ -75,7 +75,7 @@
 			enable-active-high;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 24 GPIO_ACTIVE_LOW>;
+			gpio = <&gpio0 24 GPIO_ACTIVE_HIGH>;
 		};
 
 		sata1_power: regulator at 2 {
@@ -87,7 +87,7 @@
 			enable-active-high;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 28 GPIO_ACTIVE_LOW>;
+			gpio = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
-- 
2.4.9
