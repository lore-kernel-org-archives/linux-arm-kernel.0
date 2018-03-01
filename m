From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 1 Mar 2018 14:52:08 +0200
Subject: [PATCH] ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name
Message-ID: <ca6bd71c64691209cae279e2c094ce511a9e7419.1519908633.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two usb-otg regulators for imx7d-sdb are both called
"regulator-usb-otg1-vbus" and they effectively override each other.

This is most likely a copy-paste error.

Fixes: b877039aa1fe ("ARM: dts: imx7d-sdb: Adjust the regulator nodes")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a7a5dc7..e7d2db8 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -75,21 +75,21 @@
 
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-	reg_usb_otg2_vbus: regulator-usb-otg1-vbus {
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg2_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
 	reg_can2_3v3: regulator-can2-3v3 {
 		compatible = "regulator-fixed";
-- 
2.7.4
