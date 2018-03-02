From: manu@freebsd.org (Emmanuel Vadot)
Date: Fri,  2 Mar 2018 22:38:52 +0100
Subject: [PATCH] dts: sunxi: Add eMMC for NanoPi M1 Plus
Message-ID: <20180302213852.64588-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NanoPi-M1-Plus have a 8GB eMMC, add a node for it.
This eMMC is always powered with 3.3V.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index a6e61915d648..0ca988e8c72f 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -119,6 +119,16 @@
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bits_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.15.1
