From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 30 Jun 2018 08:27:20 +0200
Subject: [linux-sunxi] ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink
 X2
Message-ID: <20180630062720.24225-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The enabling of the emac was reverted when stability issues were
discovered.

This reverts partially commit 6b0e06df5cad (Revert "ARM: dts:
sun8i: h3: Enable dwmac-sun8i on the Beelink X2")

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index cf1f970b0c6f..5d23667dc2d2 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -123,6 +123,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.18.0
