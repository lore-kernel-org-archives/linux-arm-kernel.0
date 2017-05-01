From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:08 +0200
Subject: [PATCH v5 08/20] arm: sun8i: orangepi-pc: Enable dwmac-sun8i
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Orange PI PC.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index f148111..52e6575 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -52,6 +52,7 @@
 	compatible = "xunlong,orangepi-pc", "allwinner,sun8i-h3";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -109,6 +110,13 @@
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
2.10.2
