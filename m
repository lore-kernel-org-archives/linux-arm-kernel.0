From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:59:35 +0200
Subject: [PATCH 1/6] ARM: dts: keystone: drop address and size cells from GIC
 node
Message-ID: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/keystone.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 90823eb90c1b..d0b0266d8922 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -28,8 +28,6 @@
 	gic: interrupt-controller {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-		#size-cells = <0>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0x0 0x02561000 0x0 0x1000>,
 		      <0x0 0x02562000 0x0 0x2000>,
-- 
1.9.1
