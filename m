From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 29 Jan 2015 23:07:47 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: add cpu and gpu regulators to
 rk3288-evb-act8846
Message-ID: <5715597.a6Lom1OGfJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The evaluation board using the act8846 as main pmic uses two additional
regulators to provide the cpu and gpu voltage. Add these and also add
the link to cpu supply from vdd_cpu.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index a76dd44..9db02bbe 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -17,7 +17,32 @@
 	compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
 &i2c0 {
+	vdd_cpu: syr827 at 40 {
+		compatible = "silergy,syr827";
+		fcs,suspend-voltage-selector = <1>;
+		reg = <0x40>;
+		regulator-name = "vdd_cpu";
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_gpu: syr828 at 41 {
+		compatible = "silergy,syr828";
+		fcs,suspend-voltage-selector = <1>;
+		reg = <0x41>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+	};
+
 	hym8563 at 51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
-- 
2.1.1
