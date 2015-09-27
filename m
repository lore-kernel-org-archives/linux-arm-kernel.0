From: tommyhebb@gmail.com (Thomas Hebb)
Date: Sat, 26 Sep 2015 20:47:44 -0400
Subject: [PATCH 2/4 RESEND] ARM: dts: berlin: change BG2Q's USB PHY compatible
Message-ID: <56073CB0.3060607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, BG2Q shares a compatible with BG2. This is incorrect, since
BG2 and BG2Q use different USB PLL dividers. In reality, BG2Q shares a
divider with BG2CD. Change BG2Q's USB PHY compatible string to reflect
that.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Cc: stable at vger.kernel.org
---
This patch seems to have been missed from my original series (all the
rest made it into 4.2), and as a result the BG2Q currently uses the
wrong divider.

 arch/arm/boot/dts/berlin2q.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi
b/arch/arm/boot/dts/berlin2q.dtsi
index 63a4849..d4dbd28 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -152,7 +152,7 @@
 		};

  		usb_phy2: phy at a2f400 {
-			compatible = "marvell,berlin2-usb-phy";
+			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xa2f400 0x128>;
 			#phy-cells = <0>;
 			resets = <&chip_rst 0x104 14>;
@@ -170,7 +170,7 @@
 		};

  		usb_phy0: phy at b74000 {
-			compatible = "marvell,berlin2-usb-phy";
+			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb74000 0x128>;
 			#phy-cells = <0>;
 			resets = <&chip_rst 0x104 12>;
@@ -178,7 +178,7 @@
 		};

  		usb_phy1: phy at b78000 {
-			compatible = "marvell,berlin2-usb-phy";
+			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb78000 0x128>;
 			#phy-cells = <0>;
 			resets = <&chip_rst 0x104 13>;
-- 
2.4.4
