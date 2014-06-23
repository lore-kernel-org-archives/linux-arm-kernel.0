From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 23 Jun 2014 22:25:15 +0200
Subject: [PATCH] ARM: dts: kirkwood: fix phy-connection-type for Guruplug
Message-ID: <1403555115-13111-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit eeb845459a72e792a959278b858f9c417e9995bd
 ("ARM: dts: kirkwood: set Guruplug phy-connection-type to rgmii-id")
added phy-connection-type properties to ethernet PHY nodes.

Actually, the property has to be set for the ethernet port node instead.
Fix it by moving the corresponding properties to the correct nodes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Jason,

this should go in as a fix for v3.16 where above commit appeared first.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index c5a1fc75c7a3..b2d9834bf458 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -105,7 +105,6 @@
 		compatible = "ethernet-phy-id0141.0cb0",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		phy-connection-type = "rgmii-id";
 	};
 
 	ethphy1: ethernet-phy at 1 {
@@ -113,7 +112,6 @@
 		compatible = "ethernet-phy-id0141.0cb0",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
-		phy-connection-type = "rgmii-id";
 	};
 };
 
@@ -121,6 +119,7 @@
 	status = "okay";
 	ethernet0-port at 0 {
 		phy-handle = <&ethphy0>;
+		phy-connection-type = "rgmii-id";
 	};
 };
 
@@ -128,5 +127,6 @@
 	status = "okay";
 	ethernet1-port at 0 {
 		phy-handle = <&ethphy1>;
+		phy-connection-type = "rgmii-id";
 	};
 };
-- 
2.0.0
