From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 29 Jan 2015 23:08:25 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: housekeeping off i2c0 on rk3288-evb
 boards
In-Reply-To: <5715597.a6Lom1OGfJ@diego>
References: <5715597.a6Lom1OGfJ@diego>
Message-ID: <1550421.auhbiXq1Bp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the same transfer speed on both the rk808 and act8846 variants and
remove the status=okay from the rk808 one which is already set in the
shared rk3288-evb.dtsi .

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 2 ++
 arch/arm/boot/dts/rk3288-evb-rk808.dts   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 9db02bbe..d7b8bbc 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -22,6 +22,8 @@
 };
 
 &i2c0 {
+	clock-frequency = <400000>;
+
 	vdd_cpu: syr827 at 40 {
 		compatible = "silergy,syr827";
 		fcs,suspend-voltage-selector = <1>;
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index d453ddd..3f7aa9e 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -23,7 +23,6 @@
 
 &i2c0 {
 	clock-frequency = <400000>;
-	status = "okay";
 
 	rk808: pmic at 1b {
 		compatible = "rockchip,rk808";
-- 
2.1.1
