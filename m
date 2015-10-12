From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:32 +0300
Subject: [PATCH 03/37] ARM: mvebu: Armada 388 GP: Remove unneeded regulator
 property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-4-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable-active-high regulator property only makes sense when an
enable GPIO is specified. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 2 --
 1 file changed, 2 deletions(-)

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index fd4f6fd8a2e8..ebf6e8c2c522 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -301,9 +301,7 @@
 	reg_sata0: pwr-sata0 {
 		compatible = "regulator-fixed";
 		regulator-name = "pwr_en_sata0";
-		enable-active-high;
 		regulator-always-on;
-
 	};
 
 	reg_5v_sata0: v5-sata0 {
-- 
2.4.9
