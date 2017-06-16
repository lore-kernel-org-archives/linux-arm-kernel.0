From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 17:24:34 +0530
Subject: [PATCH 07/12] ARM: dts: am57xx-idk: Move common MMC/SD properties to
 common file
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Message-ID: <20170616115439.8508-8-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM572x IDK and AM571x IDK boards have equivalent
design of how SD card and eMMC are connected.

The two EVMs mainly differ in IOdelay configuration
needed (because of difference in SoC used).

Move the common properties to am57xx-idk-common.dtsi
file which is common for both EVMs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         | 7 -------
 arch/arm/boot/dts/am572x-idk.dts         | 8 --------
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 8 ++++++++
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index ad68d1eb3bc3..e685c8e811b0 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -64,13 +64,6 @@
 	};
 };
 
-&mmc1 {
-	status = "okay";
-	vmmc-supply = <&ldo1_reg>;
-	bus-width = <4>;
-	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
-};
-
 &omap_dwc3_2 {
 	extcon = <&extcon_usb2>;
 };
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 8d538f5d9a5f..1c112eb25db4 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -76,14 +76,6 @@
 	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
 };
 
-&mmc1 {
-	status = "okay";
-	vmmc-supply = <&v3_3d>;
-	vqmmc-supply = <&ldo1_reg>;
-	bus-width = <4>;
-	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
-};
-
 &sn65hvs882 {
 	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index c536b2f5389f..47b5b384809f 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -399,6 +399,14 @@
 	dr_mode = "peripheral";
 };
 
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&v3_3d>;
+	vqmmc-supply = <&ldo1_reg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
+};
+
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&v3_3d>;
-- 
2.11.0
