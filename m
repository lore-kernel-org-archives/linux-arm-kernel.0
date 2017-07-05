From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:30:16 +0800
Subject: [PATCH v2 1/6] ARM: dts: rockchip: add regulator nodes for rk3229-evb
In-Reply-To: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499243421-21460-2-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds regulator info for rk3229-evb board.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 69 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 82e8a53..394be63 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -51,6 +51,15 @@
 		reg = <0x60000000 0x40000000>;
 	};
 
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	ext_gmac: ext_gmac {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -67,6 +76,7 @@
 		regulator-name = "vcc_host";
 		regulator-always-on;
 		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
 	};
 
 	vcc_phy: vcc-phy-regulator {
@@ -77,6 +87,57 @@
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 		regulator-boot-on;
+		vin-supply = <&vccio_1v8>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vccio_1v8: vccio-1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vccio_3v3: vccio-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vdd_arm: vdd-arm-regulator {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 25000 1>;
+		regulator-name = "vdd_arm";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+		pwm-supply = <&vcc_sys>;
+	};
+
+	vdd_log: vdd-log-regulator {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		pwm-supply = <&vcc_sys>;
 	};
 };
 
@@ -104,6 +165,14 @@
 	};
 };
 
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.0.0
