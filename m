From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 10 Jul 2016 16:27:38 +0100
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
Message-ID: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clearfog DTS should not be defining the on-board phy, this device
is located on the microsom.  Remove the duplicated definition.

Reported-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 2e9246f749a2..a6dfa8dc3423 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -208,22 +208,6 @@
 				status = "okay";
 			};
 
-			mdio at 72004 {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-
-				phy_dedicated: ethernet-phy at 0 {
-					/*
-					 * Annoyingly, the marvell phy driver
-					 * configures the LED register, rather
-					 * than preserving reset-loaded setting.
-					 * We undo that rubbish here.
-					 */
-					marvell,reg-init = <3 16 0 0x101e>;
-					reg = <0>;
-				};
-			};
-
 			pinctrl at 18000 {
 				clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
 					marvell,pins = "mpp46";
-- 
2.1.0
