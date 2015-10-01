From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:50 +0200
Subject: [PATCH 13/16] ARM: dts: lpc4357-ea4357: add i2c0 and devices
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-14-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 and some of the I2C devices on the EA4357 dev kit.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 4d2d74a064c4..391121d24daa 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -332,6 +332,14 @@
 		};
 	};
 
+	i2c0_pins: i2c0-pins {
+		i2c0_pins_cfg {
+			pins = "i2c0_scl", "i2c0_sda";
+			function = "i2c0";
+			input-enable;
+		};
+	};
+
 	sdmmc_pins: sdmmc-pins {
 		sdmmc_clk_cfg {
 			pins = "pc_0";
@@ -453,6 +461,23 @@
 	};
 };
 
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+
+	lm75 at 48 {
+		compatible = "nxp,lm75";
+		reg = <0x48>;
+	};
+
+	eeprom at 57 {
+		compatible = "microchip,24c64";
+		reg = <0x57>;
+	};
+};
+
 &emc {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.0
