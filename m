From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 12 Jul 2017 11:03:25 +0100
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the iwg20m board dependent part of the MMCIF0 device node.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 001ca91..ffce1b6 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -22,8 +22,34 @@
 		device_type = "memory";
 		reg = <2 0x00000000 0 0x20000000>;
 	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &extal_clk {
 	clock-frequency = <20000000>;
 };
+
+&pfc {
+	mmcif0_pins: mmc {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+	};
+};
+
+&mmcif0 {
+		pinctrl-0 = <&mmcif0_pins>;
+		pinctrl-names = "default";
+
+		vmmc-supply = <&reg_3p3v>;
+		bus-width = <8>;
+		non-removable;
+		status = "okay";
+};
-- 
1.9.1
