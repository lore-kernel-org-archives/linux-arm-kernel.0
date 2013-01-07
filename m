From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jan 2013 17:29:58 +0100
Subject: [PATCH 3.9] arm: mvebu: add button for OpenBlocks AX3-4
Message-ID: <1357576198-24574-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OpenBlocks AX3-4 board has one software-controlled button on the
front side, labeled "INIT", so we add minimal support for this button
in the kernel.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index b24644f..c16015c 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -72,6 +72,18 @@
 			};
 		};
 
+		gpio_keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			button at 1 {
+				label = "Init Button";
+				linux,code = <116>;
+				gpios = <&gpio1 28 0>;
+			};
+		};
+
 		mdio {
 			phy0: ethernet-phy at 0 {
 				reg = <0>;
-- 
1.7.9.5
