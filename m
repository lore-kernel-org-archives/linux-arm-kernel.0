From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:21 +0800
Subject: [PATCH v5 10/12] ARM: dts: sun6i: hummingbird: Add AXP221 regulator
 nodes
In-Reply-To: <1425988764-23618-1-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
Message-ID: <1425988764-23618-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the AXP221 regulators. Only the ones directly used
on the board are added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 56 ++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 486ffc69ac96..d13c88c6509a 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -115,7 +115,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&vcc_3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
 	cd-inverted;
@@ -150,6 +150,60 @@
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		dcdc1-supply = <&vcc_3v0>;
+		dcdc5-supply = <&vcc_dram>;
+
+		regulators {
+			x-powers,dcdc-freq = <3000>;
+
+			vcc_3v0: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-3v0";
+			};
+
+			vdd_cpu: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1320000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			vdd_gpu: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1320000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			vdd_sys_dll: dcdc4 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-sys-dll";
+			};
+
+			vcc_dram: dcdc5 {
+				regulator-always-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vcc-dram";
+			};
+
+			vcc_wifi: aldo1 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_wifi";
+			};
+
+			avcc: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "avcc";
+			};
+		};
 	};
 };
 
-- 
2.1.4
