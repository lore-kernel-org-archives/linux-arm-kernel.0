From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 20 Feb 2017 17:22:18 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun8i-h3: Add mmc2 node to the X2
Message-ID: <20170220162218.22068-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Beelink X2 has an on-board eMMC so add a node enabling
the mmc2 controller.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 25b225b7dfd6..04b04fb99a51 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -138,6 +138,16 @@
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.11.1
