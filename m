From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 08 Mar 2015 01:57:59 +0100
Subject: [PATCH] ARM: dts: rockchip: complete rk3288-evb pmic supplies
Message-ID: <52808563.Ey0qrIVQE3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the static vcc_sys regulator to the rk3288-evb, the missing
rk808 supplies from it and all the supplies of the act8846 evb-variant.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 10 ++++++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts   |  7 +++++++
 arch/arm/boot/dts/rk3288-evb.dtsi        |  9 +++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index d7b8bbc..1687e83 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -33,6 +33,7 @@
 		regulator-max-microvolt = <1350000>;
 		regulator-always-on;
 		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
 	};
 
 	vdd_gpu: syr828 at 41 {
@@ -43,6 +44,7 @@
 		regulator-min-microvolt = <850000>;
 		regulator-max-microvolt = <1350000>;
 		regulator-always-on;
+		vin-supply = <&vcc_sys>;
 	};
 
 	hym8563 at 51 {
@@ -64,6 +66,14 @@
 		reg = <0x5a>;
 		status = "okay";
 
+		vp1-supply = <&vcc_sys>;
+		vp2-supply = <&vcc_sys>;
+		vp3-supply = <&vcc_sys>;
+		vp4-supply = <&vcc_sys>;
+		inl1-supply = <&vcc_io>;
+		inl2-supply = <&vcc_sys>;
+		inl3-supply = <&vcc_20>;
+
 		regulators {
 			vcc_ddr: REG1 {
 				regulator-name = "VCC_DDR";
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index a1c294b..f62ea78 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -43,9 +43,16 @@
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
 
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
 		vcc8-supply = <&vcc_18>;
 		vcc9-supply = <&vcc_io>;
 		vcc10-supply = <&vcc_io>;
+		vcc11-supply = <&vcc_sys>;
 		vcc12-supply = <&vcc_io>;
 		vddio-supply = <&vccio_pmu>;
 
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 287a162..4a45751 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -103,6 +103,15 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &emmc {
-- 
2.1.4
