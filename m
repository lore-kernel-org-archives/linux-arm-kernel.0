From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 30 Jan 2015 00:42:30 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: enable vops and hdmi output on
 rk3288-firefly and -evb
Message-ID: <3746086.qLJlieorB7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the recently added display nodes on the firefly and evb,
letting the boards output graphic data over the hdmi port.

This includes enabling of i2c5 on the evb that is used for ddc probing and
setting the lcd-regulators to always on until the hdmi driver learns
about using them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb.dtsi     | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 3e067dd..6857730 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -104,6 +104,10 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -120,6 +124,10 @@
 	status = "okay";
 };
 
+&i2c5 {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
@@ -187,3 +195,19 @@
 &usb_host1 {
 	status = "okay";
 };
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 7f0ba9b..6dcc5e9 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -179,6 +179,10 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -265,6 +269,7 @@
 				regulator-name = "vdd10_lcd";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
 			};
 
 			vcca_18: REG7 {
@@ -303,6 +308,7 @@
 				regulator-name = "vcc18_lcd";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 			};
 		};
 	};
@@ -462,6 +468,22 @@
 	status = "okay";
 };
 
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.1.1
