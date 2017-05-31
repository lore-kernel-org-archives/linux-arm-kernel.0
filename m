From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 31 May 2017 09:18:40 +0200
Subject: [PATCH v6 09/21] arm: sun8i: orangepi-zero: Enable dwmac-sun8i
In-Reply-To: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
Message-ID: <20170531071852.12422-10-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Orange PI Zero.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 9e8b082c134f..dd3525a0f06a 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -57,6 +57,7 @@
 	aliases {
 		serial0 = &uart0;
 		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
+		ethernet0 = &emac;
 		ethernet1 = &xr819;
 	};
 
@@ -103,6 +104,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>;
-- 
2.13.0
