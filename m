From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:49 +0900
Subject: [PATCH v6 04/13] ARM: dts: Use labels for overriding nodes in
 exynos4210-smdkv310
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-8-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 280 +++++++++++++++---------------
 1 file changed, 140 insertions(+), 140 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 86216fff1b4f..043b03caff8f 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -30,181 +30,181 @@
 		stdout-path = &serial_1;
 	};
 
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-		status = "okay";
-	};
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <12000000>;
+		};
 
-	g2d at 12800000 {
-		status = "okay";
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
 	};
+};
 
-	codec at 13400000 {
-		samsung,mfc-r = <0x43000000 0x800000>;
-		samsung,mfc-l = <0x51000000 0x800000>;
-		status = "okay";
-	};
+&g2d {
+	status = "okay";
+};
 
-	serial at 13800000 {
-		status = "okay";
-	};
+&i2c_0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <100000>;
+	status = "okay";
 
-	serial at 13810000 {
-		status = "okay";
+	eeprom at 50 {
+		compatible = "samsung,24ad0xd1";
+		reg = <0x50>;
 	};
 
-	serial at 13820000 {
-		status = "okay";
+	eeprom at 52 {
+		compatible = "samsung,24ad0xd1";
+		reg = <0x52>;
 	};
+};
 
-	serial at 13830000 {
-		status = "okay";
+&keypad {
+	samsung,keypad-num-rows = <2>;
+	samsung,keypad-num-columns = <8>;
+	linux,keypad-no-autorepeat;
+	linux,keypad-wakeup;
+	pinctrl-names = "default";
+	pinctrl-0 = <&keypad_rows &keypad_cols>;
+	status = "okay";
+
+	key_1 {
+		keypad,row = <0>;
+		keypad,column = <3>;
+		linux,code = <2>;
 	};
 
-	pinctrl at 11000000 {
-		keypad_rows: keypad-rows {
-			samsung,pins = "gpx2-0", "gpx2-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
-		};
-
-		keypad_cols: keypad-cols {
-			samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
-				       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
-		};
+	key_2 {
+		keypad,row = <0>;
+		keypad,column = <4>;
+		linux,code = <3>;
 	};
 
-	keypad at 100A0000 {
-		samsung,keypad-num-rows = <2>;
-		samsung,keypad-num-columns = <8>;
-		linux,keypad-no-autorepeat;
-		linux,keypad-wakeup;
-		pinctrl-names = "default";
-		pinctrl-0 = <&keypad_rows &keypad_cols>;
-		status = "okay";
+	key_3 {
+		keypad,row = <0>;
+		keypad,column = <5>;
+		linux,code = <4>;
+	};
 
-		key_1 {
-			keypad,row = <0>;
-			keypad,column = <3>;
-			linux,code = <2>;
-		};
+	key_4 {
+		keypad,row = <0>;
+		keypad,column = <6>;
+		linux,code = <5>;
+	};
 
-		key_2 {
-			keypad,row = <0>;
-			keypad,column = <4>;
-			linux,code = <3>;
-		};
+	key_5 {
+		keypad,row = <0>;
+		keypad,column = <7>;
+		linux,code = <6>;
+	};
 
-		key_3 {
-			keypad,row = <0>;
-			keypad,column = <5>;
-			linux,code = <4>;
-		};
+	key_a {
+		keypad,row = <1>;
+		keypad,column = <3>;
+		linux,code = <30>;
+	};
 
-		key_4 {
-			keypad,row = <0>;
-			keypad,column = <6>;
-			linux,code = <5>;
-		};
+	key_b {
+		keypad,row = <1>;
+		keypad,column = <4>;
+		linux,code = <48>;
+	};
 
-		key_5 {
-			keypad,row = <0>;
-			keypad,column = <7>;
-			linux,code = <6>;
-		};
+	key_c {
+		keypad,row = <1>;
+		keypad,column = <5>;
+		linux,code = <46>;
+	};
 
-		key_a {
-			keypad,row = <1>;
-			keypad,column = <3>;
-			linux,code = <30>;
-		};
+	key_d {
+		keypad,row = <1>;
+		keypad,column = <6>;
+		linux,code = <32>;
+	};
 
-		key_b {
-			keypad,row = <1>;
-			keypad,column = <4>;
-			linux,code = <48>;
-		};
+	key_e {
+		keypad,row = <1>;
+		keypad,column = <7>;
+		linux,code = <18>;
+	};
+};
 
-		key_c {
-			keypad,row = <1>;
-			keypad,column = <5>;
-			linux,code = <46>;
-		};
+&mfc {
+	samsung,mfc-r = <0x43000000 0x800000>;
+	samsung,mfc-l = <0x51000000 0x800000>;
+	status = "okay";
+};
 
-		key_d {
-			keypad,row = <1>;
-			keypad,column = <6>;
-			linux,code = <32>;
-		};
+&pinctrl_1 {
+	keypad_rows: keypad-rows {
+		samsung,pins = "gpx2-0", "gpx2-1";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
 
-		key_e {
-			keypad,row = <1>;
-			keypad,column = <7>;
-			linux,code = <18>;
-		};
+	keypad_cols: keypad-cols {
+		samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
+			       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
 	};
+};
 
-	i2c at 13860000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <100000>;
-		status = "okay";
-
-		eeprom at 50 {
-			compatible = "samsung,24ad0xd1";
-			reg = <0x50>;
-		};
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+	status = "okay";
+};
 
-		eeprom at 52 {
-			compatible = "samsung,24ad0xd1";
-			reg = <0x52>;
-		};
-	};
+&serial_0 {
+	status = "okay";
+};
 
-	spi_2: spi at 13940000 {
-		cs-gpios = <&gpc1 2 0>;
-		status = "okay";
+&serial_1 {
+	status = "okay";
+};
 
-		w25x80 at 0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "w25x80";
-			reg = <0>;
-			spi-max-frequency = <1000000>;
+&serial_2 {
+	status = "okay";
+};
 
-			controller-data {
-				samsung,spi-feedback-delay = <0>;
-			};
+&serial_3 {
+	status = "okay";
+};
 
-			partition at 0 {
-				label = "U-Boot";
-				reg = <0x0 0x40000>;
-				read-only;
-			};
+&spi_2 {
+	cs-gpios = <&gpc1 2 0>;
+	status = "okay";
 
-			partition at 40000 {
-				label = "Kernel";
-				reg = <0x40000 0xc0000>;
-			};
+	w25x80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "w25x80";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+
+		controller-data {
+			samsung,spi-feedback-delay = <0>;
 		};
-	};
 
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <12000000>;
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x0 0x40000>;
+			read-only;
 		};
 
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
+		partition at 40000 {
+			label = "Kernel";
+			reg = <0x40000 0xc0000>;
 		};
 	};
 };
-- 
2.1.4
