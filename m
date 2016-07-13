From: sr@denx.de (Stefan Roese)
Date: Wed, 13 Jul 2016 11:55:17 +0200
Subject: [PATCH 1/3 v2] arm: mvebu: Add SPI1 pinctrl defines for Armada XP
Message-ID: <20160713095519.30790-1-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines and uses common Armada XP pinctrl settings in
armada-xp.dtsi for the SPI1 interface (MPP13,14,16,17).

Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
v2:
- Added to this dts SPI node move patchset. No functional change.

 arch/arm/boot/dts/armada-xp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 553349c..4033790 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -94,6 +94,8 @@
 			spi1: spi at 10680 {
 				compatible = "marvell,armada-xp-spi",
 						"marvell,orion-spi";
+				pinctrl-0 = <&spi1_pins>;
+				pinctrl-names = "default";
 			};
 
 
@@ -362,6 +364,12 @@
 		marvell,function = "spi0";
 	};
 
+	spi1_pins: spi1-pins {
+		marvell,pins = "mpp13", "mpp14",
+			       "mpp16", "mpp17";
+		marvell,function = "spi1";
+	};
+
 	uart2_pins: uart2-pins {
 		marvell,pins = "mpp42", "mpp43";
 		marvell,function = "uart2";
-- 
2.9.1
