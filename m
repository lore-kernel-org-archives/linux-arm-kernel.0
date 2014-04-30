From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:41 +0200
Subject: [PATCH 14/15] ARM: dts: kirkwood: set Guruplug ethernet PHY compatible
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-15-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet PHY compatible shall be "ethernet-phy-ieee802.3-c22" and
"ethernet-phy-idAAAA.BBBB" if PHY OUI id is known. We know it for
the PHY found on Guruplug, so set it accordingly.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 871a5f8afb01..f6f15e2910ed 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -101,12 +101,16 @@
 	status = "okay";
 
 	ethphy0: ethernet-phy at 0 {
-		compatible = "marvell,88e1121";
+		/* Marvell 88E1121R */
+		compatible = "ethernet-phy-id0141.0cb0",
+		             "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
 	};
 
 	ethphy1: ethernet-phy at 1 {
-		compatible = "marvell,88e1121";
+		/* Marvell 88E1121R */
+		compatible = "ethernet-phy-id0141.0cb0",
+		             "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 	};
 };
-- 
1.9.1
