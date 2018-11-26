From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 19:58:21 +0100
Subject: [PATCH v2 4/4] arm64: dts: actions: s700-cubieboard7: Enable I2C0 and
 I2C1
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Message-ID: <20181126185821.2480449-5-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 28f3f4a0f7f0..6a75fdd7ab42 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -37,3 +37,56 @@
 &uart3 {
 	status = "okay";
 };
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_default>;
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_default>;
+};
+
+&i2c2 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_default>;
+};
+
+&pinctrl {
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinmux {
+			groups = "i2c1_dummy";
+			function = "i2c1";
+		};
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinmux {
+			groups = "i2c2_dummy";
+			function = "i2c2";
+		};
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.17.2
