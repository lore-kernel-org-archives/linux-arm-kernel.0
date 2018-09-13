From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:32 -0500
Subject: [PATCH] ARM: dts: sunxi: Fix I2C bus warnings
Message-ID: <20180913181245.25484-8-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C buses. Fix the warnings in unit-addresses.

arch/arm/boot/dts/sun8i-a23-gt90h-v4.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-inet86dz.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
arch/arm/boot/dts/sun8i-a33-q8-tablet.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-utoo-p66.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: I2C bus unit address format error, expected "40"
arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
arch/arm/boot/dts/sun5i-a13-q8-tablet.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 3 ++-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 3 ++-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 8acbaab14fe5..d2a2eb8b3f26 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -92,7 +92,8 @@
 	 */
 	clock-frequency = <400000>;
 
-	touchscreen: touchscreen {
+	touchscreen: touchscreen at 40 {
+		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 880096c7e252..5e8a95af89b8 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -69,7 +69,8 @@
 	 */
 	clock-frequency = <400000>;
 
-	touchscreen: touchscreen at 0 {
+	touchscreen: touchscreen at 40 {
+		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 35859d8f3267..bf97f6244c23 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -95,7 +95,7 @@
 &i2c0 {
 	status = "okay";
 
-	axp22x: pmic at 68 {
+	axp22x: pmic at 34 {
 		compatible = "x-powers,axp221";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
-- 
2.17.1
