From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:58 +0300
Subject: [PATCH 29/37] ARM: dts: kirkwood-nsa3x0-common: Fix regulator enable
 GPIO polarity
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-30-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
index 2075a2e828f1..c4b17f396e1e 100644
--- a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
@@ -110,7 +110,7 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+			gpio = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.4.9
