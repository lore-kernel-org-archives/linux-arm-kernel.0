From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 11 Aug 2014 20:41:59 +0200
Subject: [PATCH] ARM: dts: rockchip: readd missing mmc0 pinctrl settings
Message-ID: <1626837.6qR3aISu0X@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the restructuring of the Rockchip Cortex-A9 dtsi files it seems
like the pinctrl settings vanished at some point from the mmc0 support.

This of course renders them unusable, so readd the necessary pinctrl
properties.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 2 ++
 arch/arm/boot/dts/rk3188-radxarock.dts | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 042f821d..c9d912d 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -149,6 +149,8 @@
 &mmc0 { /* sdmmc */
 	num-slots = <1>;
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
 	vmmc-supply = <&vcc_sd0>;
 
 	slot at 0 {
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 171b610..5e4e3c23 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -179,6 +179,8 @@
 &mmc0 {
 	num-slots = <1>;
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
 	vmmc-supply = <&vcc_sd0>;
 
 	slot at 0 {
-- 
2.0.1
