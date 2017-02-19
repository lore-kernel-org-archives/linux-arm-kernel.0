From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 22:41:41 +0100
Subject: [PATCH v5 1/9] ARM64: dts: meson-gxbb-odroidc2: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170219214149.30418-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state. While here also explicitly specify the phy-mode instead of
relying on the default-value from meson-gx.dtsi.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c59403adb387..6b5579522587 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -152,6 +152,11 @@
 	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
 	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
-- 
2.11.1
