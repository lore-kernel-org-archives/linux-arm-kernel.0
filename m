From: oskari@lemmela.net (Oskari Lemmela)
Date: Sat, 13 Oct 2018 11:08:44 +0300
Subject: [PATCH v4 3/7] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Message-ID: <20181013080848.29894-4-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index e5eae8bafc42..128177178615 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -49,6 +49,37 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	ac_power_supply: ac-power-supply {
+		compatible = "x-powers,axp813-ac-power-supply";
+		status = "disabled";
+	};
+
+	axp_adc: adc {
+		compatible = "x-powers,axp813-adc";
+		#io-channel-cells = <1>;
+	};
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio0_ldo: gpio0-ldo {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		gpio1_ldo: gpio1-ldo {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp813-battery-power-supply";
+		status = "disabled";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.17.1
