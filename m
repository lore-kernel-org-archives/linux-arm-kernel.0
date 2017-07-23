From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun, 23 Jul 2017 16:49:50 +0200
Subject: [linux-sunxi][PATCH 2/2] ARM: dts: sun8i: h3: Enable dwac-sun8i on
 the Beelink X2
In-Reply-To: <20170723144950.29330-1-codekipper@gmail.com>
References: <20170723144950.29330-1-codekipper@gmail.com>
Message-ID: <20170723144950.29330-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The dwmac-sun8i hardware is present on the Beelink X2.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 87d7f2cdefa6..a6c44b7043c5 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -53,7 +53,7 @@
 
 	aliases {
 		serial0 = &uart0;
-		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
+		ethernet0 = &emac;
 		ethernet1 = &sdiowifi;
 	};
 
@@ -108,6 +108,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.13.3
