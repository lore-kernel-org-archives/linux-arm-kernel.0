From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 15:18:46 +0100
Subject: [PATCH v2 10/20] ARM: dts: sun8i: Enable dwmac-sun8i on the Orange Pi
 2
In-Reply-To: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
Message-ID: <20170314141856.24560-11-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Orange PI 2.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 5b6d145..3f54b12 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -55,6 +55,7 @@
 		serial0 = &uart0;
 		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
 		ethernet1 = &rtl8189;
+		ethernet0 = &emac;
 	};
 
 	chosen {
@@ -203,3 +204,10 @@
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
-- 
2.10.2
