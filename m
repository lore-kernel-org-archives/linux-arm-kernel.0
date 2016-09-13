From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 13 Sep 2016 17:51:04 +0000
Subject: [PATCH 2/4] ARM: dts: imx28: Remove fake "reg" properties from bus
 nodes
In-Reply-To: <1473789066-8955-1-git-send-email-stefan.wahren@i2se.com>
References: <1473789066-8955-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1473789066-8955-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to specify fake "reg" properties for the internal
bus nodes based on the registers of its child devices. This also
avoids overlapping issues on adding the sram node.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28-apf28.dts      |    8 ++++----
 arch/arm/boot/dts/imx28-apf28dev.dts   |    8 ++++----
 arch/arm/boot/dts/imx28-apx4devkit.dts |    8 ++++----
 arch/arm/boot/dts/imx28-cfa10036.dts   |    8 ++++----
 arch/arm/boot/dts/imx28-cfa10037.dts   |    8 ++++----
 arch/arm/boot/dts/imx28-cfa10049.dts   |   10 +++++-----
 arch/arm/boot/dts/imx28-cfa10055.dts   |    6 +++---
 arch/arm/boot/dts/imx28-cfa10056.dts   |    4 ++--
 arch/arm/boot/dts/imx28-cfa10057.dts   |   10 +++++-----
 arch/arm/boot/dts/imx28-cfa10058.dts   |   10 +++++-----
 arch/arm/boot/dts/imx28-duckbill.dts   |    8 ++++----
 arch/arm/boot/dts/imx28-evk.dts        |    8 ++++----
 arch/arm/boot/dts/imx28-m28.dtsi       |    6 +++---
 arch/arm/boot/dts/imx28-m28cu3.dts     |    8 ++++----
 arch/arm/boot/dts/imx28-m28evk.dts     |    8 ++++----
 arch/arm/boot/dts/imx28-sps1.dts       |    8 ++++----
 arch/arm/boot/dts/imx28.dtsi           |   12 ++++--------
 17 files changed, 67 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index b6976fb..e0e9b9f 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			gpmi-nand at 8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
@@ -65,7 +65,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
@@ -74,7 +74,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index c4fadbc..1c3ecec 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -16,8 +16,8 @@
 	model = "Armadeus Systems APF28Dev docking/development board";
 	compatible = "armadeus,imx28-apf28dev", "armadeus,imx28-apf28", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
@@ -119,7 +119,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			lradc at 80050000 {
 				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
@@ -154,7 +154,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_otg_apf28dev
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index ce6115e..f534546 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -10,8 +10,8 @@
 		reg = <0x40000000 0x04000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			gpmi-nand at 8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
@@ -124,7 +124,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			saif0: saif at 80042000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif0_pins_a>;
@@ -183,7 +183,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index d016a3b..dc54b40 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				ssd1306_cfa10036: ssd1306-10036 at 0 {
 					reg = <0>;
@@ -78,7 +78,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_b>;
@@ -112,7 +112,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_otg_cfa10036>;
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index e5beaa5..e6bc433 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -19,8 +19,8 @@
 	model = "Crystalfontz CFA-10037 Board";
 	compatible = "crystalfontz,cfa10037", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				usb_pins_cfa10037: usb-10037 at 0 {
 					reg = <0>;
@@ -44,14 +44,14 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			usbphy1: usbphy at 8007e000 {
 				status = "okay";
 			};
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-0 = <&usb1_pins_a>;
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a9c347e..219644b 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -19,8 +19,8 @@
 	model = "Crystalfontz CFA-10049 Board";
 	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				usb_pins_cfa10049: usb-10049 at 0 {
 					reg = <0>;
@@ -206,7 +206,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pwm3_pins_b>;
@@ -295,7 +295,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-0 = <&usb1_pins_a>;
@@ -321,7 +321,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index 6a34114..51debef 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -20,8 +20,8 @@
 	model = "Crystalfontz CFA-10055 Board";
 	compatible = "crystalfontz,cfa10055", "crystalfontz,cfa10037", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				spi2_pins_cfa10055: spi2-cfa10055 at 0 {
 					reg = <0>;
@@ -121,7 +121,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			lradc at 80050000 {
 				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
index ba6495c..b7a4075 100644
--- a/arch/arm/boot/dts/imx28-cfa10056.dts
+++ b/arch/arm/boot/dts/imx28-cfa10056.dts
@@ -19,8 +19,8 @@
 	model = "Crystalfontz CFA-10056 Board";
 	compatible = "crystalfontz,cfa10056", "crystalfontz,cfa10037", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				spi2_pins_cfa10056: spi2-cfa10056 at 0 {
 					reg = <0>;
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 7a80bd6..a866f28 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -20,8 +20,8 @@
 	model = "Crystalfontz CFA-10057 Board";
 	compatible = "crystalfontz,cfa10057", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				usb_pins_cfa10057: usb-10057 at 0 {
 					reg = <0>;
@@ -107,7 +107,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			lradc at 80050000 {
 				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
@@ -131,7 +131,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-0 = <&usb1_pins_a>;
@@ -157,7 +157,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index f5c6dce..4e396a8 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -20,8 +20,8 @@
 	model = "Crystalfontz CFA-10058 Board";
 	compatible = "crystalfontz,cfa10058", "crystalfontz,cfa10036", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				usb_pins_cfa10058: usb-10058 at 0 {
 					reg = <0>;
@@ -80,7 +80,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			lradc at 80050000 {
 				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
@@ -98,7 +98,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-0 = <&usb1_pins_a>;
@@ -124,7 +124,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index b5bc3f5..1d92c61 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
@@ -60,7 +60,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
@@ -73,7 +73,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 4cd8216..f502054 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			gpmi-nand at 8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
@@ -168,7 +168,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			saif0: saif@80042000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif0_pins_a>;
@@ -245,7 +245,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_id_pins_a>;
diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 1bcba90..e4f50f0d 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -20,8 +20,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			gpmi-nand at 8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -31,7 +31,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index c4c4cc7..556020f 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			gpmi-nand at 8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -145,7 +145,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_b>;
@@ -176,7 +176,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 8d04e57..f9bbe66 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -16,8 +16,8 @@
 	model = "DENX M28EVK";
 	compatible = "denx,m28evk", "fsl,imx28";
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
@@ -122,7 +122,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			saif0: saif at 80042000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif0_pins_a>;
@@ -197,7 +197,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			vbus-supply = <&reg_usb0_vbus>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 5ddfb16..52482ba 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -21,8 +21,8 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
+	apb {
+		apbh {
 			pinctrl at 80018000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
@@ -67,7 +67,7 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
@@ -103,7 +103,7 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		usb0: usb at 80080000 {
 			vbus-supply = <&reg_usb0_vbus>;
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3aabf65..e483f61 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -49,18 +49,16 @@
 		};
 	};
 
-	apb at 80000000 {
+	apb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x80000000 0x80000>;
 		ranges;
 
-		apbh at 80000000 {
+		apbh {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x80000000 0x3c900>;
 			ranges;
 
 			icoll: interrupt-controller at 80000000 {
@@ -1056,11 +1054,10 @@
 			};
 		};
 
-		apbx at 80040000 {
+		apbx {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			reg = <0x80040000 0x40000>;
 			ranges;
 
 			clks: clkctrl at 80040000 {
@@ -1234,11 +1231,10 @@
 		};
 	};
 
-	ahb at 80080000 {
+	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x80080000 0x80000>;
 		ranges;
 
 		usb0: usb at 80080000 {
-- 
1.7.9.5
