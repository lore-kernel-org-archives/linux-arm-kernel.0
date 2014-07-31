From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 31 Jul 2014 07:37:03 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add watchdog node
In-Reply-To: <1507670.CGuyIht1az@diego>
References: <1507670.CGuyIht1az@diego>
Message-ID: <24685135.nT0fF4Dz3O@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Designware compatible watchdog found on RK3xxx Cortex-A9 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 4 ++++
 arch/arm/boot/dts/rk3066a.dtsi         | 4 ++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 4 ++++
 arch/arm/boot/dts/rk3188.dtsi          | 4 ++++
 arch/arm/boot/dts/rk3xxx.dtsi          | 8 ++++++++
 5 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 8b479f7..042f821d 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -188,3 +188,7 @@
 &uart3 {
 	status = "okay";
 };
+
+&wdt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 9c34da4..879a818 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -425,3 +425,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_xfer>;
 };
+
+&wdt {
+	compatible = "rockchip,rk3066-wdt", "snps,dw-wdt";
+};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 4195f5a..171b610 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -221,3 +221,7 @@
 &uart3 {
 	status = "okay";
 };
+
+&wdt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 27215e0..ee801a9 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -400,3 +400,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_xfer>;
 };
+
+&wdt {
+	compatible = "rockchip,rk3188-wdt", "snps,dw-wdt";
+};
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index c6f0561..8caf85d 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -174,6 +174,14 @@
 		status = "disabled";
 	};
 
+	wdt: watchdog at 2004c000 {
+		compatible = "snps,dw-wdt";
+		reg = <0x2004c000 0x100>;
+		clocks = <&cru PCLK_WDT>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pwm2: pwm at 20050020 {
 		compatible = "rockchip,rk2928-pwm";
 		reg = <0x20050020 0x10>;
-- 
2.0.1
