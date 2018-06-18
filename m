From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 18 Jun 2018 16:11:09 +0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
Message-ID: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two different regulators are defined with the same name and label but
distinct properties.

The first definition was added with the first board dts and the second
was added when upstream added flexcan support.

Looking at schematics it is indeed gpio2 14 connected to the STB pin of
the CAN transceiver so remove the first definition.

The second definition entirely overrides the first so this already
worked and this patch results in no DTB change, just a cleanup.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/imx7d-sdb.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 940849163104..9f9e6a1e3b72 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -69,18 +69,10 @@
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-	reg_can2_3v3: regulator-can2-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_vref_1v8: regulator-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vref-1v8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
-- 
2.17.1
