From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:42 +0200
Subject: [PATCH 15/15] ARM: dts: kirkwood: set Guruplug phy-connection-type to
 rgmii-id
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-16-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet PHYs found on Globalscale Guruplug are connected by RGMII-ID.
Set the corresponding phy-connection-type property accordingly.

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
 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index f6f15e2910ed..c5a1fc75c7a3 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -105,6 +105,7 @@
 		compatible = "ethernet-phy-id0141.0cb0",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
+		phy-connection-type = "rgmii-id";
 	};
 
 	ethphy1: ethernet-phy at 1 {
@@ -112,6 +113,7 @@
 		compatible = "ethernet-phy-id0141.0cb0",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		phy-connection-type = "rgmii-id";
 	};
 };
 
-- 
1.9.1
