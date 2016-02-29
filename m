From: sr@denx.de (Stefan Roese)
Date: Mon, 29 Feb 2016 10:58:34 +0100
Subject: [PATCH] arm: mvebu: Add SPI1 pinctrl defines for Armada XP
Message-ID: <1456739914-12096-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines and uses common Armada XP pinctrl settings in
armada-xp.dtsi for the SPI1 interface (MPP13,14,16,17).

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index be23196..c779e31 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -94,6 +94,8 @@
 			spi1: spi at 10680 {
 				compatible = "marvell,armada-xp-spi",
 						"marvell,orion-spi";
+				pinctrl-0 = <&spi1_pins>;
+				pinctrl-names = "default";
 			};
 
 
@@ -343,6 +345,12 @@
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
2.7.2
