From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 15:19:13 +0800
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Add ethernet phy reset gpio
 properties
Message-ID: <1417591153-27177-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Hummingbird A31 board, the RTL8211E ethernet phy has its reset
line connect to a gpio pin, instead of floating like on other boards.
Add the stmmac properties for describing the reset gpio.

The reset delays were taken from the RTL8211E datasheet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 6e924d9..55a367a 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -139,6 +139,9 @@
 			pinctrl-0 = <&gmac_pins_rgmii_a>;
 			phy = <&phy1>;
 			phy-mode = "rgmii";
+			snps,reset-gpio = <&pio 0 21 0>;
+			snps,reset-active-low;
+			snps,reset-delays-us = <0 10000 30000>;
 			status = "okay";
 
 			phy1: ethernet-phy at 1 {
-- 
2.1.3
