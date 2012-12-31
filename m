From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 31 Dec 2012 11:49:17 +0800
Subject: [PATCH 2/2] ARM: dts: imx: use nodes label in board dts
In-Reply-To: <1356925757-5704-1-git-send-email-shawn.guo@linaro.org>
References: <1356925757-5704-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1356925757-5704-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following omap3-evm.dts way, it changes all imx dts files to use label
in board dts to refer to nodes defined by soc dtsi.  Thus, the board
dts files become easier to read and edit with the least indentation
levels.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts |   30 +--
 arch/arm/boot/dts/imx25.dtsi          |    2 +-
 arch/arm/boot/dts/imx27-apf27.dts     |   82 +++---
 arch/arm/boot/dts/imx27-pdk.dts       |   20 +-
 arch/arm/boot/dts/imx31-bug.dts       |   12 +-
 arch/arm/boot/dts/imx51-babbage.dts   |  456 ++++++++++++++++-----------------
 arch/arm/boot/dts/imx53-ard.dts       |  126 +++++----
 arch/arm/boot/dts/imx53-evk.dts       |  194 +++++++-------
 arch/arm/boot/dts/imx53-qsb.dts       |  380 ++++++++++++++-------------
 arch/arm/boot/dts/imx53-smd.dts       |  294 +++++++++++----------
 arch/arm/boot/dts/imx6q-arm2.dts      |  124 +++++----
 arch/arm/boot/dts/imx6q-sabreauto.dts |   64 +++--
 arch/arm/boot/dts/imx6q-sabrelite.dts |  216 ++++++++--------
 arch/arm/boot/dts/imx6q-sabresd.dts   |  102 ++++----
 arch/arm/boot/dts/imx6q.dtsi          |    2 +-
 15 files changed, 1008 insertions(+), 1096 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index d81f8a0..eb9b9d1 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -19,26 +19,18 @@
 	memory {
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
+};
 
-	soc {
-		aips at 43f00000 {
-			uart1: serial at 43f90000 {
-				status = "okay";
-			};
-		};
+&uart1 {
+	status = "okay";
+};
 
-		spba at 50000000 {
-			fec: ethernet at 50038000 {
-				status = "okay";
-				phy-mode = "rmii";
-			};
-		};
+&fec {
+	status = "okay";
+	phy-mode = "rmii";
+};
 
-		emi at 80000000 {
-			nand at bb000000 {
-				nand-on-flash-bbt;
-				status = "okay";
-			};
-		};
-	};
+&nfc {
+	nand-on-flash-bbt;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index e1b13eb..94f3305 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -499,7 +499,7 @@
 			reg = <0x80000000 0x3b002000>;
 			ranges;
 
-			nand at bb000000 {
+			nfc: nand at bb000000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index c0327c0..b464c80 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -32,58 +32,54 @@
 			clock-frequency = <0>;
 		};
 	};
+};
 
-	soc {
-		aipi at 10000000 {
-			serial at 1000a000 {
-				status = "okay";
-			};
+&uart1 {
+	status = "okay";
+};
 
-			ethernet at 1002b000 {
-				status = "okay";
-			};
-		};
+&fec {
+	status = "okay";
+};
 
-		nand at d8000000 {
-			status = "okay";
-			nand-bus-width = <16>;
-			nand-ecc-mode = "hw";
-			nand-on-flash-bbt;
+&nfc {
+	status = "okay";
+	nand-bus-width = <16>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
 
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0 0x100000>;
-			};
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0 0x100000>;
+	};
 
-			partition at 100000 {
-				label = "env";
-				reg = <0x100000 0x80000>;
-			};
+	partition at 100000 {
+		label = "env";
+		reg = <0x100000 0x80000>;
+	};
 
-			partition at 180000 {
-				label = "env2";
-				reg = <0x180000 0x80000>;
-			};
+	partition at 180000 {
+		label = "env2";
+		reg = <0x180000 0x80000>;
+	};
 
-			partition at 200000 {
-				label = "firmware";
-				reg = <0x200000 0x80000>;
-			};
+	partition at 200000 {
+		label = "firmware";
+		reg = <0x200000 0x80000>;
+	};
 
-			partition at 280000 {
-				label = "dtb";
-				reg = <0x280000 0x80000>;
-			};
+	partition at 280000 {
+		label = "dtb";
+		reg = <0x280000 0x80000>;
+	};
 
-			partition at 300000 {
-				label = "kernel";
-				reg = <0x300000 0x500000>;
-			};
+	partition at 300000 {
+		label = "kernel";
+		reg = <0x300000 0x500000>;
+	};
 
-			partition at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0xf800000>;
-			};
-		};
+	partition at 800000 {
+		label = "rootfs";
+		reg = <0x800000 0xf800000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 0290978..41cd110 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -19,19 +19,13 @@
 	memory {
 		reg = <0x0 0x0>;
 	};
+};
 
-	soc {
-		aipi at 10000000 { /* aipi1 */
-			uart1: serial at 1000a000 {
-				fsl,uart-has-rtscts;
-				status = "okay";
-			};
-		};
+&uart1 {
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
 
-		aipi at 10020000 { /* aipi2 */
-			ethernet at 1002b000 {
-				status = "okay";
-			};
-		};
-	};
+&fec {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
index 24731cb..e0bcdde 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -19,13 +19,9 @@
 	memory {
 		reg = <0x80000000 0x8000000>; /* 128M */
 	};
+};
 
-	soc {
-		aips at 43f00000 { /* AIPS1 */
-			uart5: serial at 43fb4000 {
-				fsl,uart-has-rtscts;
-				status = "okay";
-			};
-		};
-	};
+&uart5 {
+	fsl,uart-has-rtscts;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 567e7ee..fb33aff 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -21,239 +21,20 @@
 		reg = <0x90000000 0x20000000>;
 	};
 
-	soc {
-		display at di0 {
-			compatible = "fsl,imx-parallel-display";
-			crtcs = <&ipu 0>;
-			interface-pix-fmt = "rgb24";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
-		};
-
-		display at di1 {
-			compatible = "fsl,imx-parallel-display";
-			crtcs = <&ipu 1>;
-			interface-pix-fmt = "rgb565";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
-		};
-
-		aips at 70000000 { /* aips-1 */
-			spba at 70000000 {
-				esdhc at 70004000 { /* ESDHC1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc1_1>;
-					fsl,cd-controller;
-					fsl,wp-controller;
-					status = "okay";
-				};
-
-				esdhc at 70008000 { /* ESDHC2 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc2_1>;
-					cd-gpios = <&gpio1 6 0>;
-					wp-gpios = <&gpio1 5 0>;
-					status = "okay";
-				};
-
-				uart3: serial at 7000c000 {
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_uart3_1>;
-					fsl,uart-has-rtscts;
-					status = "okay";
-				};
-
-				ecspi at 70010000 { /* ECSPI1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_ecspi1_1>;
-					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
-					status = "okay";
-
-					pmic: mc13892 at 0 {
-						#address-cells = <1>;
-						#size-cells = <0>;
-						compatible = "fsl,mc13892";
-						spi-max-frequency = <6000000>;
-						reg = <0>;
-						interrupt-parent = <&gpio1>;
-						interrupts = <8 0x4>;
-
-						regulators {
-							sw1_reg: sw1 {
-								regulator-min-microvolt = <600000>;
-								regulator-max-microvolt = <1375000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							sw2_reg: sw2 {
-								regulator-min-microvolt = <900000>;
-								regulator-max-microvolt = <1850000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							sw3_reg: sw3 {
-								regulator-min-microvolt = <1100000>;
-								regulator-max-microvolt = <1850000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							sw4_reg: sw4 {
-								regulator-min-microvolt = <1100000>;
-								regulator-max-microvolt = <1850000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							vpll_reg: vpll {
-								regulator-min-microvolt = <1050000>;
-								regulator-max-microvolt = <1800000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							vdig_reg: vdig {
-								regulator-min-microvolt = <1650000>;
-								regulator-max-microvolt = <1650000>;
-								regulator-boot-on;
-							};
-
-							vsd_reg: vsd {
-								regulator-min-microvolt = <1800000>;
-								regulator-max-microvolt = <3150000>;
-							};
-
-							vusb2_reg: vusb2 {
-								regulator-min-microvolt = <2400000>;
-								regulator-max-microvolt = <2775000>;
-								regulator-boot-on;
-								regulator-always-on;
-							};
-
-							vvideo_reg: vvideo {
-								regulator-min-microvolt = <2775000>;
-								regulator-max-microvolt = <2775000>;
-							};
-
-							vaudio_reg: vaudio {
-								regulator-min-microvolt = <2300000>;
-								regulator-max-microvolt = <3000000>;
-							};
-
-							vcam_reg: vcam {
-								regulator-min-microvolt = <2500000>;
-								regulator-max-microvolt = <3000000>;
-							};
-
-							vgen1_reg: vgen1 {
-								regulator-min-microvolt = <1200000>;
-								regulator-max-microvolt = <1200000>;
-							};
-
-							vgen2_reg: vgen2 {
-								regulator-min-microvolt = <1200000>;
-								regulator-max-microvolt = <3150000>;
-								regulator-always-on;
-							};
-
-							vgen3_reg: vgen3 {
-								regulator-min-microvolt = <1800000>;
-								regulator-max-microvolt = <2900000>;
-								regulator-always-on;
-							};
-						};
-					};
-
-					flash: at45db321d at 1 {
-						#address-cells = <1>;
-						#size-cells = <1>;
-						compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
-						spi-max-frequency = <25000000>;
-						reg = <1>;
-
-						partition at 0 {
-							label = "U-Boot";
-							reg = <0x0 0x40000>;
-							read-only;
-						};
-
-						partition at 40000 {
-							label = "Kernel";
-							reg = <0x40000 0x3c0000>;
-						};
-					};
-				};
-
-				ssi2: ssi at 70014000 {
-					fsl,mode = "i2s-slave";
-					status = "okay";
-				};
-			};
-
-			iomuxc at 73fa8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							694  0x20d5	/* MX51_PAD_GPIO1_0__SD1_CD */
-							697  0x20d5	/* MX51_PAD_GPIO1_1__SD1_WP */
-							737  0x100	/* MX51_PAD_GPIO1_5__GPIO1_5 */
-							740  0x100	/* MX51_PAD_GPIO1_6__GPIO1_6 */
-							121  0x5	/* MX51_PAD_EIM_A27__GPIO2_21 */
-							402  0x85	/* MX51_PAD_CSPI1_SS0__GPIO4_24 */
-							405  0x85	/* MX51_PAD_CSPI1_SS1__GPIO4_25 */
-						>;
-					};
-				};
-			};
-
-			uart1: serial at 73fbc000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1_1>;
-				fsl,uart-has-rtscts;
-				status = "okay";
-			};
-
-			uart2: serial at 73fc0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2_1>;
-				status = "okay";
-			};
-		};
-
-		aips at 80000000 {	/* aips-2 */
-			i2c at 83fc4000 { /* I2C2 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c2_1>;
-				status = "okay";
-
-				sgtl5000: codec at 0a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-					clock-frequency = <26000000>;
-					VDDA-supply = <&vdig_reg>;
-					VDDIO-supply = <&vvideo_reg>;
-				};
-			};
-
-			audmux at 83fd0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_audmux_1>;
-				status = "okay";
-			};
+	display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu 0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+	};
 
-			ethernet at 83fec000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_fec_1>;
-				phy-mode = "mii";
-				status = "okay";
-			};
-		};
+	display at di1 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu 1>;
+		interface-pix-fmt = "rgb565";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp2_1>;
 	};
 
 	gpio-keys {
@@ -281,3 +62,214 @@
 		mux-ext-port = <3>;
 	};
 };
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	fsl,cd-controller;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	cd-gpios = <&gpio1 6 0>;
+	wp-gpios = <&gpio1 5 0>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
+	status = "okay";
+
+	pmic: mc13892 at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mc13892";
+		spi-max-frequency = <6000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 0x4>;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1375000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vpll_reg: vpll {
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdig_reg: vdig {
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+			};
+
+			vsd_reg: vsd {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3150000>;
+			};
+
+			vusb2_reg: vusb2 {
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vvideo_reg: vvideo {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+			};
+
+			vaudio_reg: vaudio {
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vcam_reg: vcam {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3150000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	flash: at45db321d at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+		spi-max-frequency = <25000000>;
+		reg = <1>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x0 0x40000>;
+			read-only;
+		};
+
+		partition at 40000 {
+			label = "Kernel";
+			reg = <0x40000 0x3c0000>;
+		};
+	};
+};
+
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				694  0x20d5	/* MX51_PAD_GPIO1_0__SD1_CD */
+				697  0x20d5	/* MX51_PAD_GPIO1_1__SD1_WP */
+				737  0x100	/* MX51_PAD_GPIO1_5__GPIO1_5 */
+				740  0x100	/* MX51_PAD_GPIO1_6__GPIO1_6 */
+				121  0x5	/* MX51_PAD_EIM_A27__GPIO2_21 */
+				402  0x85	/* MX51_PAD_CSPI1_SS0__GPIO4_24 */
+				405  0x85	/* MX51_PAD_CSPI1_SS1__GPIO4_25 */
+			>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clock-frequency = <26000000>;
+		VDDA-supply = <&vdig_reg>;
+		VDDIO-supply = <&vvideo_reg>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "mii";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 4be76f2..e049fd0 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -21,72 +21,6 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
-	soc {
-		aips at 50000000 { /* AIPS1 */
-			spba at 50000000 {
-				esdhc at 50004000 { /* ESDHC1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc1_2>;
-					cd-gpios = <&gpio1 1 0>;
-					wp-gpios = <&gpio1 9 0>;
-					status = "okay";
-				};
-			};
-
-			iomuxc at 53fa8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							1077 0x80000000	/* MX53_PAD_GPIO_1__GPIO1_1 */
-							1085 0x80000000	/* MX53_PAD_GPIO_9__GPIO1_9 */
-							486  0x80000000	/* MX53_PAD_EIM_EB3__GPIO2_31 */
-							739  0x80000000	/* MX53_PAD_GPIO_10__GPIO4_0 */
-							218  0x80000000	/* MX53_PAD_DISP0_DAT16__GPIO5_10 */
-							226  0x80000000	/* MX53_PAD_DISP0_DAT17__GPIO5_11 */
-							233  0x80000000	/* MX53_PAD_DISP0_DAT18__GPIO5_12 */
-							241  0x80000000	/* MX53_PAD_DISP0_DAT19__GPIO5_13 */
-							429  0x80000000	/* MX53_PAD_EIM_D16__EMI_WEIM_D_16 */
-							435  0x80000000	/* MX53_PAD_EIM_D17__EMI_WEIM_D_17 */
-							441  0x80000000	/* MX53_PAD_EIM_D18__EMI_WEIM_D_18 */
-							448  0x80000000	/* MX53_PAD_EIM_D19__EMI_WEIM_D_19 */
-							456  0x80000000	/* MX53_PAD_EIM_D20__EMI_WEIM_D_20 */
-							464  0x80000000	/* MX53_PAD_EIM_D21__EMI_WEIM_D_21 */
-							471  0x80000000	/* MX53_PAD_EIM_D22__EMI_WEIM_D_22 */
-							477  0x80000000	/* MX53_PAD_EIM_D23__EMI_WEIM_D_23 */
-							492  0x80000000	/* MX53_PAD_EIM_D24__EMI_WEIM_D_24 */
-							500  0x80000000	/* MX53_PAD_EIM_D25__EMI_WEIM_D_25 */
-							508  0x80000000	/* MX53_PAD_EIM_D26__EMI_WEIM_D_26 */
-							516  0x80000000	/* MX53_PAD_EIM_D27__EMI_WEIM_D_27 */
-							524  0x80000000	/* MX53_PAD_EIM_D28__EMI_WEIM_D_28 */
-							532  0x80000000	/* MX53_PAD_EIM_D29__EMI_WEIM_D_29 */
-							540  0x80000000	/* MX53_PAD_EIM_D30__EMI_WEIM_D_30 */
-							548  0x80000000	/* MX53_PAD_EIM_D31__EMI_WEIM_D_31 */
-							637  0x80000000	/* MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0 */
-							642  0x80000000	/* MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1 */
-							647  0x80000000	/* MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2 */
-							652  0x80000000	/* MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3 */
-							657  0x80000000	/* MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4 */
-							662  0x80000000	/* MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5 */
-							667  0x80000000	/* MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6 */
-							611  0x80000000	/* MX53_PAD_EIM_OE__EMI_WEIM_OE */
-							616  0x80000000	/* MX53_PAD_EIM_RW__EMI_WEIM_RW */
-							607  0x80000000	/* MX53_PAD_EIM_CS1__EMI_WEIM_CS_1 */
-						>;
-					};
-				};
-			};
-
-			uart1: serial at 53fbc000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1_2>;
-				status = "okay";
-			};
-		};
-	};
-
 	eim-cs1 at f4000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -162,3 +96,63 @@
 		};
 	};
 };
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_2>;
+	cd-gpios = <&gpio1 1 0>;
+	wp-gpios = <&gpio1 9 0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				1077 0x80000000	/* MX53_PAD_GPIO_1__GPIO1_1 */
+				1085 0x80000000	/* MX53_PAD_GPIO_9__GPIO1_9 */
+				486  0x80000000	/* MX53_PAD_EIM_EB3__GPIO2_31 */
+				739  0x80000000	/* MX53_PAD_GPIO_10__GPIO4_0 */
+				218  0x80000000	/* MX53_PAD_DISP0_DAT16__GPIO5_10 */
+				226  0x80000000	/* MX53_PAD_DISP0_DAT17__GPIO5_11 */
+				233  0x80000000	/* MX53_PAD_DISP0_DAT18__GPIO5_12 */
+				241  0x80000000	/* MX53_PAD_DISP0_DAT19__GPIO5_13 */
+				429  0x80000000	/* MX53_PAD_EIM_D16__EMI_WEIM_D_16 */
+				435  0x80000000	/* MX53_PAD_EIM_D17__EMI_WEIM_D_17 */
+				441  0x80000000	/* MX53_PAD_EIM_D18__EMI_WEIM_D_18 */
+				448  0x80000000	/* MX53_PAD_EIM_D19__EMI_WEIM_D_19 */
+				456  0x80000000	/* MX53_PAD_EIM_D20__EMI_WEIM_D_20 */
+				464  0x80000000	/* MX53_PAD_EIM_D21__EMI_WEIM_D_21 */
+				471  0x80000000	/* MX53_PAD_EIM_D22__EMI_WEIM_D_22 */
+				477  0x80000000	/* MX53_PAD_EIM_D23__EMI_WEIM_D_23 */
+				492  0x80000000	/* MX53_PAD_EIM_D24__EMI_WEIM_D_24 */
+				500  0x80000000	/* MX53_PAD_EIM_D25__EMI_WEIM_D_25 */
+				508  0x80000000	/* MX53_PAD_EIM_D26__EMI_WEIM_D_26 */
+				516  0x80000000	/* MX53_PAD_EIM_D27__EMI_WEIM_D_27 */
+				524  0x80000000	/* MX53_PAD_EIM_D28__EMI_WEIM_D_28 */
+				532  0x80000000	/* MX53_PAD_EIM_D29__EMI_WEIM_D_29 */
+				540  0x80000000	/* MX53_PAD_EIM_D30__EMI_WEIM_D_30 */
+				548  0x80000000	/* MX53_PAD_EIM_D31__EMI_WEIM_D_31 */
+				637  0x80000000	/* MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0 */
+				642  0x80000000	/* MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1 */
+				647  0x80000000	/* MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2 */
+				652  0x80000000	/* MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3 */
+				657  0x80000000	/* MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4 */
+				662  0x80000000	/* MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5 */
+				667  0x80000000	/* MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6 */
+				611  0x80000000	/* MX53_PAD_EIM_OE__EMI_WEIM_OE */
+				616  0x80000000	/* MX53_PAD_EIM_RW__EMI_WEIM_RW */
+				607  0x80000000	/* MX53_PAD_EIM_CS1__EMI_WEIM_CS_1 */
+			>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_2>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index a124d1e..85a89b5 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -21,107 +21,6 @@
 		reg = <0x70000000 0x80000000>;
 	};
 
-	soc {
-		aips at 50000000 { /* AIPS1 */
-			spba at 50000000 {
-				esdhc at 50004000 { /* ESDHC1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc1_1>;
-					cd-gpios = <&gpio3 13 0>;
-					wp-gpios = <&gpio3 14 0>;
-					status = "okay";
-				};
-
-				ecspi at 50010000 { /* ECSPI1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_ecspi1_1>;
-					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
-					status = "okay";
-
-					flash: at45db321d at 1 {
-						#address-cells = <1>;
-						#size-cells = <1>;
-						compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
-						spi-max-frequency = <25000000>;
-						reg = <1>;
-
-						partition at 0 {
-							label = "U-Boot";
-							reg = <0x0 0x40000>;
-							read-only;
-						};
-
-						partition at 40000 {
-							label = "Kernel";
-							reg = <0x40000 0x3c0000>;
-						};
-					};
-				};
-
-				esdhc at 50020000 { /* ESDHC3 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc3_1>;
-					cd-gpios = <&gpio3 11 0>;
-					wp-gpios = <&gpio3 12 0>;
-					status = "okay";
-				};
-			};
-
-			iomuxc at 53fa8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							424  0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
-							449  0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
-							693  0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
-							697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
-							701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
-							705  0x80000000	/* MX53_PAD_EIM_DA14__GPIO3_14 */
-							868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
-							873  0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
-						>;
-					};
-				};
-			};
-
-			uart1: serial at 53fbc000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1_1>;
-				status = "okay";
-			};
-		};
-
-		aips at 60000000 {	/* AIPS2 */
-			i2c at 63fc4000 { /* I2C2 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c2_1>;
-				status = "okay";
-
-				pmic: mc13892 at 08 {
-					compatible = "fsl,mc13892", "fsl,mc13xxx";
-					reg = <0x08>;
-				};
-
-				codec: sgtl5000 at 0a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-				};
-			};
-
-			ethernet at 63fec000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_fec_1>;
-				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio7 6 0>;
-				status = "okay";
-			};
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -132,3 +31,96 @@
 		};
 	};
 };
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio3 13 0>;
+	wp-gpios = <&gpio3 14 0>;
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
+	status = "okay";
+
+	flash: at45db321d at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+		spi-max-frequency = <25000000>;
+		reg = <1>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x0 0x40000>;
+			read-only;
+		};
+
+		partition at 40000 {
+			label = "Kernel";
+			reg = <0x40000 0x3c0000>;
+		};
+	};
+};
+
+&esdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	cd-gpios = <&gpio3 11 0>;
+	wp-gpios = <&gpio3 12 0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				424  0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
+				449  0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
+				693  0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
+				697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
+				701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+				705  0x80000000	/* MX53_PAD_EIM_DA14__GPIO3_14 */
+				868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+				873  0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
+			>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	pmic: mc13892 at 08 {
+		compatible = "fsl,mc13892", "fsl,mc13xxx";
+		reg = <0x08>;
+	};
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio7 6 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index b007553..05cc562 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -21,200 +21,6 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
-	soc {
-		aips at 50000000 { /* AIPS1 */
-			spba at 50000000 {
-				esdhc at 50004000 { /* ESDHC1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc1_1>;
-					cd-gpios = <&gpio3 13 0>;
-					status = "okay";
-				};
-
-				ssi2: ssi at 50014000 {
-					fsl,mode = "i2s-slave";
-					status = "okay";
-				};
-
-				esdhc at 50020000 { /* ESDHC3 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc3_1>;
-					cd-gpios = <&gpio3 11 0>;
-					wp-gpios = <&gpio3 12 0>;
-					status = "okay";
-				};
-			};
-
-			iomuxc at 53fa8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							1071 0x80000000	/* MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK */
-							1141 0x80000000	/* MX53_PAD_GPIO_8__GPIO1_8 */
-							982  0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
-							989  0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
-							693  0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
-							697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
-							701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
-							868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
-							1149 0x80000000 /* MX53_PAD_GPIO_16__GPIO7_11 */
-						>;
-					};
-
-					led_pin_gpio7_7: led_gpio7_7 at 0 {
-						fsl,pins = <
-							873  0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
-						>;
-					};
-				};
-
-			};
-
-			uart1: serial at 53fbc000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1_1>;
-				status = "okay";
-			};
-		};
-
-		aips at 60000000 {	/* AIPS2 */
-			i2c at 63fc4000 { /* I2C2 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c2_1>;
-				status = "okay";
-
-				sgtl5000: codec at 0a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-					VDDA-supply = <&reg_3p2v>;
-					VDDIO-supply = <&reg_3p2v>;
-				};
-			};
-
-			i2c at 63fc8000 { /* I2C1 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c1_1>;
-				status = "okay";
-
-				accelerometer: mma8450 at 1c {
-					compatible = "fsl,mma8450";
-					reg = <0x1c>;
-				};
-
-				pmic: dialog at 48 {
-					compatible = "dlg,da9053-aa", "dlg,da9052";
-					reg = <0x48>;
-					interrupt-parent = <&gpio7>;
-					interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */
-
-					regulators {
-						buck1_reg: buck1 {
-							regulator-min-microvolt = <500000>;
-							regulator-max-microvolt = <2075000>;
-							regulator-always-on;
-						};
-
-						buck2_reg: buck2 {
-							regulator-min-microvolt = <500000>;
-							regulator-max-microvolt = <2075000>;
-							regulator-always-on;
-						};
-
-						buck3_reg: buck3 {
-							regulator-min-microvolt = <925000>;
-					                regulator-max-microvolt = <2500000>;
-							regulator-always-on;
-						};
-
-						buck4_reg: buck4 {
-							regulator-min-microvolt = <925000>;
-					                regulator-max-microvolt = <2500000>;
-							regulator-always-on;
-						};
-
-						ldo1_reg: ldo1 {
-							regulator-min-microvolt = <600000>;
-							regulator-max-microvolt = <1800000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-
-						ldo2_reg: ldo2 {
-							regulator-min-microvolt = <600000>;
-							regulator-max-microvolt = <1800000>;
-							regulator-always-on;
-						};
-
-						ldo3_reg: ldo3 {
-							regulator-min-microvolt = <600000>;
-					                regulator-max-microvolt = <1800000>;
-							regulator-always-on;
-						};
-
-						ldo4_reg: ldo4 {
-							regulator-min-microvolt = <1725000>;
-					                regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-
-						ldo5_reg: ldo5 {
-							regulator-min-microvolt = <1725000>;
-					                regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-
-						ldo6_reg: ldo6 {
-							regulator-min-microvolt = <1200000>;
-					                regulator-max-microvolt = <3600000>;
-							regulator-always-on;
-						};
-
-						ldo7_reg: ldo7 {
-							regulator-min-microvolt = <1200000>;
-					                regulator-max-microvolt = <3600000>;
-							regulator-always-on;
-						};
-
-						ldo8_reg: ldo8 {
-							regulator-min-microvolt = <1200000>;
-					                regulator-max-microvolt = <3600000>;
-							regulator-always-on;
-						};
-
-						ldo9_reg: ldo9 {
-							regulator-min-microvolt = <1200000>;
-					                regulator-max-microvolt = <3600000>;
-							regulator-always-on;
-						};
-
-						ldo10_reg: ldo10 {
-							regulator-min-microvolt = <1250000>;
-					                regulator-max-microvolt = <3650000>;
-							regulator-always-on;
-						};
-					};
-				};
-			};
-
-			audmux at 63fd0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_audmux_1>;
-				status = "okay";
-			};
-
-			ethernet at 63fec000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_fec_1>;
-				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio7 6 0>;
-				status = "okay";
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -276,3 +82,189 @@
 		mux-ext-port = <5>;
 	};
 };
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio3 13 0>;
+	status = "okay";
+};
+
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&esdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	cd-gpios = <&gpio3 11 0>;
+	wp-gpios = <&gpio3 12 0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				1071 0x80000000	/* MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK */
+				1141 0x80000000	/* MX53_PAD_GPIO_8__GPIO1_8 */
+				982  0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
+				989  0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
+				693  0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
+				697  0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
+				701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+				868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+				1149 0x80000000 /* MX53_PAD_GPIO_16__GPIO7_11 */
+			>;
+		};
+
+		led_pin_gpio7_7: led_gpio7_7 at 0 {
+			fsl,pins = <
+				873  0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
+			>;
+		};
+	};
+
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_3p2v>;
+		VDDIO-supply = <&reg_3p2v>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+
+	accelerometer: mma8450 at 1c {
+		compatible = "fsl,mma8450";
+		reg = <0x1c>;
+	};
+
+	pmic: dialog at 48 {
+		compatible = "dlg,da9053-aa", "dlg,da9052";
+		reg = <0x48>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2075000>;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2075000>;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-min-microvolt = <925000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			buck4_reg: buck4 {
+				regulator-min-microvolt = <925000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-min-microvolt = <1725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo5_reg: ldo5 {
+				regulator-min-microvolt = <1725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: ldo6 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo7_reg: ldo7 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo8_reg: ldo8 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo10_reg: ldo10 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio7 6 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 06c6858..995554c 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -21,157 +21,6 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
-	soc {
-		aips at 50000000 { /* AIPS1 */
-			spba at 50000000 {
-				esdhc at 50004000 { /* ESDHC1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc1_1>;
-					cd-gpios = <&gpio3 13 0>;
-					wp-gpios = <&gpio4 11 0>;
-					status = "okay";
-				};
-
-				esdhc at 50008000 { /* ESDHC2 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc2_1>;
-					non-removable;
-					status = "okay";
-				};
-
-				uart3: serial at 5000c000 {
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_uart3_1>;
-					fsl,uart-has-rtscts;
-					status = "okay";
-				};
-
-				ecspi at 50010000 { /* ECSPI1 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_ecspi1_1>;
-					fsl,spi-num-chipselects = <2>;
-					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
-					status = "okay";
-
-					zigbee: mc1323 at 0 {
-						compatible = "fsl,mc1323";
-						spi-max-frequency = <8000000>;
-						reg = <0>;
-					};
-
-					flash: m25p32 at 1 {
-						#address-cells = <1>;
-						#size-cells = <1>;
-						compatible = "st,m25p32", "st,m25p";
-						spi-max-frequency = <20000000>;
-						reg = <1>;
-
-						partition at 0 {
-							label = "U-Boot";
-							reg = <0x0 0x40000>;
-							read-only;
-						};
-
-						partition at 40000 {
-							label = "Kernel";
-							reg = <0x40000 0x3c0000>;
-						};
-					};
-				};
-
-				esdhc at 50020000 { /* ESDHC3 */
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_esdhc3_1>;
-					non-removable;
-					status = "okay";
-				};
-			};
-
-			iomuxc at 53fa8000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							982  0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
-							989  0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
-							424  0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
-							701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
-							449  0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
-							43   0x80000000	/* MX53_PAD_KEY_ROW2__GPIO4_11 */
-							868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
-						>;
-					};
-				};
-			};
-
-			uart1: serial at 53fbc000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart1_1>;
-				status = "okay";
-			};
-
-			uart2: serial at 53fc0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2_1>;
-				status = "okay";
-			};
-		};
-
-		aips at 60000000 {	/* AIPS2 */
-			i2c at 63fc4000 { /* I2C2 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c2_1>;
-				status = "okay";
-
-				codec: sgtl5000 at 0a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-				};
-
-				magnetometer: mag3110 at 0e {
-					compatible = "fsl,mag3110";
-					reg = <0x0e>;
-				};
-
-				touchkey: mpr121 at 5a {
-					compatible = "fsl,mpr121";
-					reg = <0x5a>;
-				};
-			};
-
-			i2c at 63fc8000 { /* I2C1 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c1_1>;
-				status = "okay";
-
-				accelerometer: mma8450 at 1c {
-					compatible = "fsl,mma8450";
-					reg = <0x1c>;
-				};
-
-				camera: ov5642 at 3c {
-					compatible = "ovti,ov5642";
-					reg = <0x3c>;
-				};
-
-				pmic: dialog at 48 {
-					compatible = "dialog,da9053", "dialog,da9052";
-					reg = <0x48>;
-				};
-			};
-
-			ethernet at 63fec000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_fec_1>;
-				phy-mode = "rmii";
-				phy-reset-gpios = <&gpio7 6 0>;
-				status = "okay";
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -188,3 +37,146 @@
 		};
 	};
 };
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio3 13 0>;
+	wp-gpios = <&gpio4 11 0>;
+	status = "okay";
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	non-removable;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
+	status = "okay";
+
+	zigbee: mc1323 at 0 {
+		compatible = "fsl,mc1323";
+		spi-max-frequency = <8000000>;
+		reg = <0>;
+	};
+
+	flash: m25p32 at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p32", "st,m25p";
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0x0 0x40000>;
+			read-only;
+		};
+
+		partition at 40000 {
+			label = "Kernel";
+			reg = <0x40000 0x3c0000>;
+		};
+	};
+};
+
+&esdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				982  0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
+				989  0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
+				424  0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
+				701  0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+				449  0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
+				43   0x80000000	/* MX53_PAD_KEY_ROW2__GPIO4_11 */
+				868  0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+			>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+	};
+
+	magnetometer: mag3110 at 0e {
+		compatible = "fsl,mag3110";
+		reg = <0x0e>;
+	};
+
+	touchkey: mpr121 at 5a {
+		compatible = "fsl,mpr121";
+		reg = <0x5a>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+
+	accelerometer: mma8450 at 1c {
+		compatible = "fsl,mma8450";
+		reg = <0x1c>;
+	};
+
+	camera: ov5642 at 3c {
+		compatible = "ovti,ov5642";
+		reg = <0x3c>;
+	};
+
+	pmic: dialog at 48 {
+		compatible = "dialog,da9053", "dialog,da9052";
+		reg = <0x48>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio7 6 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 5bfa02a..53eb241 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -21,71 +21,6 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
-	soc {
-		gpmi-nand at 00112000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_gpmi_nand_1>;
-			status = "disabled"; /* gpmi nand conflicts with SD */
-		};
-
-		aips-bus at 02000000 { /* AIPS1 */
-			iomuxc at 020e0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							176  0x80000000	/* MX6Q_PAD_EIM_D25__GPIO_3_25 */
-						>;
-					};
-				};
-
-				arm2 {
-					pinctrl_usdhc3_arm2: usdhc3grp-arm2 {
-						fsl,pins = <
-							1363 0x80000000	/* MX6Q_PAD_NANDF_CS0__GPIO_6_11 */
-							1369 0x80000000 /* MX6Q_PAD_NANDF_CS1__GPIO_6_14 */
-						>;
-					};
-				};
-			};
-		};
-
-		aips-bus at 02100000 { /* AIPS2 */
-			ethernet at 02188000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_enet_2>;
-				phy-mode = "rgmii";
-				status = "okay";
-			};
-
-			usdhc at 02198000 { /* uSDHC3 */
-				cd-gpios = <&gpio6 11 0>;
-				wp-gpios = <&gpio6 14 0>;
-				vmmc-supply = <&reg_3p3v>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc3_1
-					     &pinctrl_usdhc3_arm2>;
-				status = "okay";
-			};
-
-			usdhc at 0219c000 { /* uSDHC4 */
-				non-removable;
-				vmmc-supply = <&reg_3p3v>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc4_1>;
-				status = "okay";
-			};
-
-			uart4: serial at 021f0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart4_1>;
-				status = "okay";
-			};
-		};
-	};
-
 	regulators {
 		compatible = "simple-bus";
 
@@ -108,3 +43,62 @@
 		};
 	};
 };
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+	status = "disabled"; /* gpmi nand conflicts with SD */
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				176  0x80000000	/* MX6Q_PAD_EIM_D25__GPIO_3_25 */
+			>;
+		};
+	};
+
+	arm2 {
+		pinctrl_usdhc3_arm2: usdhc3grp-arm2 {
+			fsl,pins = <
+				1363 0x80000000	/* MX6Q_PAD_NANDF_CS0__GPIO_6_11 */
+				1369 0x80000000 /* MX6Q_PAD_NANDF_CS1__GPIO_6_14 */
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_2>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&usdhc3 {
+	cd-gpios = <&gpio6 11 0>;
+	wp-gpios = <&gpio6 14 0>;
+	vmmc-supply = <&reg_3p3v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_1
+		     &pinctrl_usdhc3_arm2>;
+	status = "okay";
+};
+
+&usdhc4 {
+	non-removable;
+	vmmc-supply = <&reg_3p3v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 826e4ad..656d489 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -20,45 +20,39 @@
 	memory {
 		reg = <0x10000000 0x80000000>;
 	};
+};
 
-	soc {
-		aips-bus at 02000000 { /* AIPS1 */
-			iomuxc at 020e0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
 
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							1376 0x80000000	/* MX6Q_PAD_NANDF_CS2__GPIO_6_15 */
-							13   0x80000000	/* MX6Q_PAD_SD2_DAT2__GPIO_1_13 */
-						>;
-					};
-				};
-			};
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				1376 0x80000000	/* MX6Q_PAD_NANDF_CS2__GPIO_6_15 */
+				13   0x80000000	/* MX6Q_PAD_SD2_DAT2__GPIO_1_13 */
+			>;
 		};
+	};
+};
 
-		aips-bus at 02100000 { /* AIPS2 */
-			uart4: serial at 021f0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart4_1>;
-				status = "okay";
-			};
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "okay";
+};
 
-			ethernet at 02188000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_enet_2>;
-				phy-mode = "rgmii";
-				status = "okay";
-			};
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_2>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
 
-			usdhc at 02198000 { /* uSDHC3 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc3_1>;
-				cd-gpios = <&gpio6 15 0>;
-				wp-gpios = <&gpio1 13 0>;
-				status = "okay";
-			};
-		};
-	};
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	cd-gpios = <&gpio6 15 0>;
+	wp-gpios = <&gpio1 13 0>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d152328..2ce355c 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -21,118 +21,6 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	soc {
-		aips-bus at 02000000 { /* AIPS1 */
-			spba-bus at 02000000 {
-				ecspi at 02008000 { /* eCSPI1 */
-					fsl,spi-num-chipselects = <1>;
-					cs-gpios = <&gpio3 19 0>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_ecspi1_1>;
-					status = "okay";
-
-					flash: m25p80 at 0 {
-						compatible = "sst,sst25vf016b";
-						spi-max-frequency = <20000000>;
-						reg = <0>;
-					};
-				};
-
-				ssi1: ssi at 02028000 {
-					fsl,mode = "i2s-slave";
-					status = "okay";
-				};
-			};
-
-			iomuxc at 020e0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							1450 0x80000000	/* MX6Q_PAD_NANDF_D6__GPIO_2_6 */
-							1458 0x80000000	/* MX6Q_PAD_NANDF_D7__GPIO_2_7 */
-							121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
-							144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
-							152  0x80000000	/* MX6Q_PAD_EIM_D23__GPIO_3_23 */
-							1262 0x80000000 /* MX6Q_PAD_SD3_DAT5__GPIO_7_0 */
-							1270 0x1f0b0	/* MX6Q_PAD_SD3_DAT4__GPIO_7_1 */
-							953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
-						>;
-					};
-				};
-			};
-		};
-
-		aips-bus at 02100000 { /* AIPS2 */
-			usb at 02184000 { /* USB OTG */
-				vbus-supply = <&reg_usb_otg_vbus>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usbotg_1>;
-				disable-over-current;
-				status = "okay";
-			};
-
-			usb at 02184200 { /* USB1 */
-				status = "okay";
-			};
-
-			ethernet at 02188000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_enet_1>;
-				phy-mode = "rgmii";
-				phy-reset-gpios = <&gpio3 23 0>;
-				status = "okay";
-			};
-
-			usdhc at 02198000 { /* uSDHC3 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc3_2>;
-				cd-gpios = <&gpio7 0 0>;
-				wp-gpios = <&gpio7 1 0>;
-				vmmc-supply = <&reg_3p3v>;
-				status = "okay";
-			};
-
-			usdhc at 0219c000 { /* uSDHC4 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc4_2>;
-				cd-gpios = <&gpio2 6 0>;
-				wp-gpios = <&gpio2 7 0>;
-				vmmc-supply = <&reg_3p3v>;
-				status = "okay";
-			};
-
-			audmux at 021d8000 {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_audmux_1>;
-			};
-
-			uart2: serial at 021e8000 {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_uart2_1>;
-			};
-
-			i2c at 021a0000 { /* I2C1 */
-				status = "okay";
-				clock-frequency = <100000>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_i2c1_1>;
-
-				codec: sgtl5000 at 0a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-					clocks = <&clks 169>;
-					VDDA-supply = <&reg_2p5v>;
-					VDDIO-supply = <&reg_3p3v>;
-				};
-			};
-		};
-	};
-
 	regulators {
 		compatible = "simple-bus";
 
@@ -176,3 +64,107 @@
 		mux-ext-port = <4>;
 	};
 };
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 19 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		compatible = "sst,sst25vf016b";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				1450 0x80000000	/* MX6Q_PAD_NANDF_D6__GPIO_2_6 */
+				1458 0x80000000	/* MX6Q_PAD_NANDF_D7__GPIO_2_7 */
+				121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
+				144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
+				152  0x80000000	/* MX6Q_PAD_EIM_D23__GPIO_3_23 */
+				1262 0x80000000 /* MX6Q_PAD_SD3_DAT5__GPIO_7_0 */
+				1270 0x1f0b0	/* MX6Q_PAD_SD3_DAT4__GPIO_7_1 */
+				953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
+			>;
+		};
+	};
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg_1>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 0>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_2>;
+	cd-gpios = <&gpio7 0 0>;
+	wp-gpios = <&gpio7 1 0>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_2>;
+	cd-gpios = <&gpio2 6 0>;
+	wp-gpios = <&gpio2 7 0>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&audmux {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks 169>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index a424025..2dea304 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -21,61 +21,6 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	soc {
-		aips-bus at 02000000 { /* AIPS1 */
-			spba-bus at 02000000 {
-				uart1: serial at 02020000 {
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_uart1_1>;
-					status = "okay";
-				};
-			};
-
-			iomuxc at 020e0000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_hog>;
-
-				hog {
-					pinctrl_hog: hoggrp {
-						fsl,pins = <
-							1004 0x80000000 /* MX6Q_PAD_GPIO_4__GPIO_1_4 */
-							1012 0x80000000 /* MX6Q_PAD_GPIO_5__GPIO_1_5 */
-							1402 0x80000000	/* MX6Q_PAD_NANDF_D0__GPIO_2_0 */
-							1410 0x80000000	/* MX6Q_PAD_NANDF_D1__GPIO_2_1 */
-							1418 0x80000000	/* MX6Q_PAD_NANDF_D2__GPIO_2_2 */
-							1426 0x80000000	/* MX6Q_PAD_NANDF_D3__GPIO_2_3 */
-						>;
-					};
-				};
-			};
-		};
-
-		aips-bus at 02100000 { /* AIPS2 */
-			ethernet at 02188000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_enet_1>;
-				phy-mode = "rgmii";
-				status = "okay";
-			};
-
-			usdhc at 02194000 { /* uSDHC2 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc2_1>;
-				cd-gpios = <&gpio2 2 0>;
-				wp-gpios = <&gpio2 3 0>;
-				status = "okay";
-			};
-
-			usdhc at 02198000 { /* uSDHC3 */
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_usdhc3_1>;
-				cd-gpios = <&gpio2 0 0>;
-				wp-gpios = <&gpio2 1 0>;
-				status = "okay";
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -92,3 +37,50 @@
 		};
 	};
 };
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				1004 0x80000000 /* MX6Q_PAD_GPIO_4__GPIO_1_4 */
+				1012 0x80000000 /* MX6Q_PAD_GPIO_5__GPIO_1_5 */
+				1402 0x80000000	/* MX6Q_PAD_NANDF_D0__GPIO_2_0 */
+				1410 0x80000000	/* MX6Q_PAD_NANDF_D1__GPIO_2_1 */
+				1418 0x80000000	/* MX6Q_PAD_NANDF_D2__GPIO_2_2 */
+				1426 0x80000000	/* MX6Q_PAD_NANDF_D3__GPIO_2_3 */
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2_1>;
+	cd-gpios = <&gpio2 2 0>;
+	wp-gpios = <&gpio2 3 0>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	cd-gpios = <&gpio2 0 0>;
+	wp-gpios = <&gpio2 1 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..cf25f94 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -108,7 +108,7 @@
 			clocks = <&clks 106>;
 		};
 
-		nfc: gpmi-nand at 00112000 {
+		gpmi: gpmi-nand at 00112000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.9.5
