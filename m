From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:30:29 +0900
Subject: [PATCH v6 10/13] ARM: dts: Use labels for overriding nodes in
 exynos4412-smdk4412
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851432-413-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4412-smdk4412.dts | 210 +++++++++++++++---------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index b9256afbcc68..c2421df1fa43 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -28,135 +28,135 @@
 		stdout-path = &serial_1;
 	};
 
-	g2d at 10800000 {
-		status = "okay";
-	};
-
-	pinctrl at 11000000 {
-		keypad_rows: keypad-rows {
-			samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
 		};
 
-		keypad_cols: keypad-cols {
-			samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
-				       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
 		};
 	};
+};
 
-	keypad at 100A0000 {
-		samsung,keypad-num-rows = <3>;
-		samsung,keypad-num-columns = <8>;
-		linux,keypad-no-autorepeat;
-		linux,keypad-wakeup;
-		pinctrl-0 = <&keypad_rows &keypad_cols>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		key_1 {
-			keypad,row = <1>;
-			keypad,column = <3>;
-			linux,code = <2>;
-		};
-
-		key_2 {
-			keypad,row = <1>;
-			keypad,column = <4>;
-			linux,code = <3>;
-		};
-
-		key_3 {
-			keypad,row = <1>;
-			keypad,column = <5>;
-			linux,code = <4>;
-		};
-
-		key_4 {
-			keypad,row = <1>;
-			keypad,column = <6>;
-			linux,code = <5>;
-		};
+&g2d {
+	status = "okay";
+};
 
-		key_5 {
-			keypad,row = <1>;
-			keypad,column = <7>;
-			linux,code = <6>;
-		};
+&keypad {
+	samsung,keypad-num-rows = <3>;
+	samsung,keypad-num-columns = <8>;
+	linux,keypad-no-autorepeat;
+	linux,keypad-wakeup;
+	pinctrl-0 = <&keypad_rows &keypad_cols>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	key_1 {
+		keypad,row = <1>;
+		keypad,column = <3>;
+		linux,code = <2>;
+	};
 
-		key_A {
-			keypad,row = <2>;
-			keypad,column = <6>;
-			linux,code = <30>;
-		};
+	key_2 {
+		keypad,row = <1>;
+		keypad,column = <4>;
+		linux,code = <3>;
+	};
 
-		key_B {
-			keypad,row = <2>;
-			keypad,column = <7>;
-			linux,code = <48>;
-		};
+	key_3 {
+		keypad,row = <1>;
+		keypad,column = <5>;
+		linux,code = <4>;
+	};
 
-		key_C {
-			keypad,row = <0>;
-			keypad,column = <5>;
-			linux,code = <46>;
-		};
+	key_4 {
+		keypad,row = <1>;
+		keypad,column = <6>;
+		linux,code = <5>;
+	};
 
-		key_D {
-			keypad,row = <2>;
-			keypad,column = <5>;
-			linux,code = <32>;
-		};
+	key_5 {
+		keypad,row = <1>;
+		keypad,column = <7>;
+		linux,code = <6>;
+	};
 
-		key_E {
-			keypad,row = <0>;
-			keypad,column = <7>;
-			linux,code = <18>;
-		};
+	key_A {
+		keypad,row = <2>;
+		keypad,column = <6>;
+		linux,code = <30>;
 	};
 
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
-		pinctrl-names = "default";
-		status = "okay";
+	key_B {
+		keypad,row = <2>;
+		keypad,column = <7>;
+		linux,code = <48>;
 	};
 
-	codec at 13400000 {
-		samsung,mfc-r = <0x43000000 0x800000>;
-		samsung,mfc-l = <0x51000000 0x800000>;
-		status = "okay";
+	key_C {
+		keypad,row = <0>;
+		keypad,column = <5>;
+		linux,code = <46>;
 	};
 
-	serial at 13800000 {
-		status = "okay";
+	key_D {
+		keypad,row = <2>;
+		keypad,column = <5>;
+		linux,code = <32>;
 	};
 
-	serial at 13810000 {
-		status = "okay";
+	key_E {
+		keypad,row = <0>;
+		keypad,column = <7>;
+		linux,code = <18>;
 	};
+};
+
+&mfc {
+	samsung,mfc-r = <0x43000000 0x800000>;
+	samsung,mfc-l = <0x51000000 0x800000>;
+	status = "okay";
+};
 
-	serial at 13820000 {
-		status = "okay";
+&pinctrl_1 {
+	keypad_rows: keypad-rows {
+		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
 	};
 
-	serial at 13830000 {
-		status = "okay";
+	keypad_cols: keypad-cols {
+		samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
+			       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
 	};
+};
 
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
+	pinctrl-names = "default";
+	status = "okay";
+};
 
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
 };
-- 
2.1.4
