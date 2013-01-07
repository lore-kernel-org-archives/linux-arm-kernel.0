From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:51 +0100
Subject: [PATCH 09/11] ARM: nomadik: add I2C devices to the device tree
Message-ID: <1357599411-7619-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the GPIO-based I2C devices to the Nomadik device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 1a12f10..58d6b6a 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -134,6 +134,58 @@
 		};
 	};
 
+	/* I2C0 connected to the STw4811 power management chip */
+	i2c0 {
+		compatible = "i2c-gpio";
+		gpios = <&gpio1 31 0 /* sda */
+			 &gpio1 30 0 /* scl */
+			>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		stw4811 at 2d {
+			   compatible = "st,stw4811";
+			   reg = <0x2d>;
+		};
+	};
+
+	/* I2C1 connected to various sensors */
+	i2c1 {
+		compatible = "i2c-gpio";
+		gpios = <&gpio1 22 0 /* sda */
+			 &gpio1 21 0 /* scl */
+			>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		camera at 2d {
+			   compatible = "st,camera";
+			   reg = <0x10>;
+		};
+		stw5095 at 1a {
+			   compatible = "st,stw5095";
+			   reg = <0x1a>;
+		};
+		lis3lv02dl at 1d {
+			   compatible = "st,lis3lv02dl";
+			   reg = <0x1d>;
+		};
+	};
+
+	/* I2C2 connected to the USB portions of the STw4811 only */
+	i2c2 {
+		compatible = "i2c-gpio";
+		gpios = <&gpio2 10 0 /* sda */
+			 &gpio2 9 0 /* scl */
+			>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		stw4811 at 2d {
+			   compatible = "st,stw4811-usb";
+			   reg = <0x2d>;
+		};
+	};
+
 	amba {
 		compatible = "arm,amba-bus";
 		#address-cells = <1>;
-- 
1.7.11.7
