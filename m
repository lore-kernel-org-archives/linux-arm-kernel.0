From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 07 Mar 2015 15:30:06 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: add input supplies for the act8846 on
 Radxa Rock
In-Reply-To: <1709506.shJhJsMxOa@phil>
References: <1709506.shJhJsMxOa@phil>
Message-ID: <1971287.rRrUEZJPze@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Radxa Rock board most supplies come from the static 5v vsys supply, but
the inl1-supply comes from the REG4 of the act8846 itself. Model this dependency
using the added supply-handling to make sure the supplying regulator gets handled
correctly and not accidentially turned off.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
I'll apply this one to my dts branch myself, if patch 1/2 is accepted

 arch/arm/boot/dts/rk3188-radxarock.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 9a09579..bdf8570 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -103,6 +103,14 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vsys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
 };
 
 &emac {
@@ -148,6 +156,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&act8846_dvs0_ctl>;
 
+		vp1-supply = <&vsys>;
+		vp2-supply = <&vsys>;
+		vp3-supply = <&vsys>;
+		vp4-supply = <&vsys>;
+		inl1-supply = <&vcc_io>;
+		inl2-supply = <&vsys>;
+		inl3-supply = <&vsys>;
+
 		regulators {
 			vcc_ddr: REG1 {
 				regulator-name = "VCC_DDR";
-- 
2.1.4
