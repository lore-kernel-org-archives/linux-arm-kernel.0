From: marco.franchi@nxp.com (Marco Franchi)
Date: Fri, 22 Sep 2017 11:30:42 -0300
Subject: [PATCH v2] ARM: dts: imx6ul: Remove leading zeroes from unit addresses
Message-ID: <1506090642-10537-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warnings are seen with W=1:

Warning (unit_address_format): Node /interrupt-controller at 00a01000 unit 
name should not have leading 0s
Warning (simple_bus_reg): Node /soc/sram at 00900000 simple-bus unit address 
format error, expected "900000"
Warning (simple_bus_reg): Node /soc/dma-apbh at 01804000 simple-bus unit 
address format error, expected "1804000"
(...)

Remove the leading zeroes from unit addresses to fix the warnings.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
- Send to the correct list address
 arch/arm/boot/dts/imx6ul.dtsi | 142 +++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f11a241..2057ee6 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -98,7 +98,7 @@
 		};
 	};
 
-	intc: interrupt-controller at 00a01000 {
+	intc: interrupt-controller at a01000 {
 		compatible = "arm,gic-400", "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
@@ -149,12 +149,12 @@
 			status = "disabled";
 		};
 
-		ocram: sram at 00900000 {
+		ocram: sram at 900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
 		};
 
-		dma_apbh: dma-apbh at 01804000 {
+		dma_apbh: dma-apbh at 1804000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
@@ -167,7 +167,7 @@
 			clocks = <&clks IMX6UL_CLK_APBHDMA>;
 		};
 
-		gpmi: gpmi-nand at 01806000         {
+		gpmi: gpmi-nand at 1806000         {
 			compatible = "fsl,imx6q-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -187,21 +187,21 @@
 			status = "disabled";
 		};
 
-		aips1: aips-bus at 02000000 {
+		aips1: aips-bus at 2000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x02000000 0x100000>;
 			ranges;
 
-			spba-bus at 02000000 {
+			spba-bus at 2000000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0x02000000 0x40000>;
 				ranges;
 
-				ecspi1: ecspi at 02008000 {
+				ecspi1: ecspi at 2008000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
@@ -213,7 +213,7 @@
 					status = "disabled";
 				};
 
-				ecspi2: ecspi at 0200c000 {
+				ecspi2: ecspi at 200c000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
@@ -225,7 +225,7 @@
 					status = "disabled";
 				};
 
-				ecspi3: ecspi at 02010000 {
+				ecspi3: ecspi at 2010000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
@@ -237,7 +237,7 @@
 					status = "disabled";
 				};
 
-				ecspi4: ecspi at 02014000 {
+				ecspi4: ecspi at 2014000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
@@ -249,7 +249,7 @@
 					status = "disabled";
 				};
 
-				uart7: serial at 02018000 {
+				uart7: serial at 2018000 {
 					compatible = "fsl,imx6ul-uart",
 						     "fsl,imx6q-uart";
 					reg = <0x02018000 0x4000>;
@@ -260,7 +260,7 @@
 					status = "disabled";
 				};
 
-				uart1: serial at 02020000 {
+				uart1: serial at 2020000 {
 					compatible = "fsl,imx6ul-uart",
 						     "fsl,imx6q-uart";
 					reg = <0x02020000 0x4000>;
@@ -271,7 +271,7 @@
 					status = "disabled";
 				};
 
-				uart8: serial at 02024000 {
+				uart8: serial at 2024000 {
 					compatible = "fsl,imx6ul-uart",
 						     "fsl,imx6q-uart";
 					reg = <0x02024000 0x4000>;
@@ -282,7 +282,7 @@
 					status = "disabled";
 				};
 
-				sai1: sai at 02028000 {
+				sai1: sai at 2028000 {
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x02028000 0x4000>;
@@ -297,7 +297,7 @@
 					status = "disabled";
 				};
 
-				sai2: sai at 0202c000 {
+				sai2: sai at 202c000 {
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x0202c000 0x4000>;
@@ -312,7 +312,7 @@
 					status = "disabled";
 				};
 
-				sai3: sai at 02030000 {
+				sai3: sai at 2030000 {
 					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
 					reg = <0x02030000 0x4000>;
@@ -328,7 +328,7 @@
 				};
 			};
 
-			tsc: tsc at 02040000 {
+			tsc: tsc at 2040000 {
 				compatible = "fsl,imx6ul-tsc";
 				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
@@ -339,7 +339,7 @@
 				status = "disabled";
 			};
 
-			pwm1: pwm at 02080000 {
+			pwm1: pwm at 2080000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
@@ -350,7 +350,7 @@
 				status = "disabled";
 			};
 
-			pwm2: pwm at 02084000 {
+			pwm2: pwm at 2084000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
@@ -361,7 +361,7 @@
 				status = "disabled";
 			};
 
-			pwm3: pwm at 02088000 {
+			pwm3: pwm at 2088000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
@@ -372,7 +372,7 @@
 				status = "disabled";
 			};
 
-			pwm4: pwm at 0208c000 {
+			pwm4: pwm at 208c000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
@@ -383,7 +383,7 @@
 				status = "disabled";
 			};
 
-			can1: flexcan at 02090000 {
+			can1: flexcan at 2090000 {
 				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
 				reg = <0x02090000 0x4000>;
 				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -393,7 +393,7 @@
 				status = "disabled";
 			};
 
-			can2: flexcan at 02094000 {
+			can2: flexcan at 2094000 {
 				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
 				reg = <0x02094000 0x4000>;
 				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
@@ -403,7 +403,7 @@
 				status = "disabled";
 			};
 
-			gpt1: gpt at 02098000 {
+			gpt1: gpt at 2098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -412,7 +412,7 @@
 				clock-names = "ipg", "per";
 			};
 
-			gpio1: gpio at 0209c000 {
+			gpio1: gpio at 209c000 {
 				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
@@ -425,7 +425,7 @@
 					      <&iomuxc 16 33 16>;
 			};
 
-			gpio2: gpio at 020a0000 {
+			gpio2: gpio at 20a0000 {
 				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
@@ -437,7 +437,7 @@
 				gpio-ranges = <&iomuxc 0 49 16>, <&iomuxc 16 111 6>;
 			};
 
-			gpio3: gpio at 020a4000 {
+			gpio3: gpio at 20a4000 {
 				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
@@ -449,7 +449,7 @@
 				gpio-ranges = <&iomuxc 0 65 29>;
 			};
 
-			gpio4: gpio at 020a8000 {
+			gpio4: gpio at 20a8000 {
 				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
@@ -461,7 +461,7 @@
 				gpio-ranges = <&iomuxc 0 94 17>, <&iomuxc 17 117 12>;
 			};
 
-			gpio5: gpio at 020ac000 {
+			gpio5: gpio at 20ac000 {
 				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -473,7 +473,7 @@
 				gpio-ranges = <&iomuxc 0 7 10>, <&iomuxc 10 5 2>;
 			};
 
-			fec2: ethernet at 020b4000 {
+			fec2: ethernet at 20b4000 {
 				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x020b4000 0x4000>;
 				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
@@ -490,7 +490,7 @@
 				status = "disabled";
 			};
 
-			kpp: kpp at 020b8000 {
+			kpp: kpp at 20b8000 {
 				compatible = "fsl,imx6ul-kpp", "fsl,imx6q-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -498,14 +498,14 @@
 				status = "disabled";
 			};
 
-			wdog1: wdog at 020bc000 {
+			wdog1: wdog at 20bc000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_WDOG1>;
 			};
 
-			wdog2: wdog at 020c0000 {
+			wdog2: wdog at 20c0000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
@@ -513,7 +513,7 @@
 				status = "disabled";
 			};
 
-			clks: ccm at 020c4000 {
+			clks: ccm at 20c4000 {
 				compatible = "fsl,imx6ul-ccm";
 				reg = <0x020c4000 0x4000>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
@@ -523,7 +523,7 @@
 				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
 			};
 
-			anatop: anatop at 020c8000 {
+			anatop: anatop at 20c8000 {
 				compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
 					     "syscon", "simple-bus";
 				reg = <0x020c8000 0x1000>;
@@ -580,7 +580,7 @@
 				};
 			};
 
-			usbphy1: usbphy at 020c9000 {
+			usbphy1: usbphy at 20c9000 {
 				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
 				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
@@ -589,7 +589,7 @@
 				fsl,anatop = <&anatop>;
 			};
 
-			usbphy2: usbphy at 020ca000 {
+			usbphy2: usbphy at 20ca000 {
 				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
@@ -598,7 +598,7 @@
 				fsl,anatop = <&anatop>;
 			};
 
-			snvs: snvs at 020cc000 {
+			snvs: snvs at 20cc000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x020cc000 0x4000>;
 
@@ -628,17 +628,17 @@
 				};
 			};
 
-			epit1: epit at 020d0000 {
+			epit1: epit at 20d0000 {
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			epit2: epit at 020d4000 {
+			epit2: epit at 20d4000 {
 				reg = <0x020d4000 0x4000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			src: src at 020d8000 {
+			src: src at 20d8000 {
 				compatible = "fsl,imx6ul-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
@@ -646,7 +646,7 @@
 				#reset-cells = <1>;
 			};
 
-			gpc: gpc at 020dc000 {
+			gpc: gpc at 20dc000 {
 				compatible = "fsl,imx6ul-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
@@ -655,18 +655,18 @@
 				interrupt-parent = <&intc>;
 			};
 
-			iomuxc: iomuxc at 020e0000 {
+			iomuxc: iomuxc at 20e0000 {
 				compatible = "fsl,imx6ul-iomuxc";
 				reg = <0x020e0000 0x4000>;
 			};
 
-			gpr: iomuxc-gpr at 020e4000 {
+			gpr: iomuxc-gpr at 20e4000 {
 				compatible = "fsl,imx6ul-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x020e4000 0x4000>;
 			};
 
-			gpt2: gpt at 020e8000 {
+			gpt2: gpt at 20e8000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x020e8000 0x4000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -675,7 +675,7 @@
 				clock-names = "ipg", "per";
 			};
 
-			sdma: sdma at 020ec000 {
+			sdma: sdma at 20ec000 {
 				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
@@ -687,7 +687,7 @@
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
 			};
 
-			pwm5: pwm at 020f0000 {
+			pwm5: pwm at 20f0000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f0000 0x4000>;
 				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
@@ -698,7 +698,7 @@
 				status = "disabled";
 			};
 
-			pwm6: pwm at 020f4000 {
+			pwm6: pwm at 20f4000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f4000 0x4000>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
@@ -709,7 +709,7 @@
 				status = "disabled";
 			};
 
-			pwm7: pwm at 020f8000 {
+			pwm7: pwm at 20f8000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f8000 0x4000>;
 				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
@@ -720,7 +720,7 @@
 				status = "disabled";
 			};
 
-			pwm8: pwm at 020fc000 {
+			pwm8: pwm at 20fc000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020fc000 0x4000>;
 				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
@@ -732,14 +732,14 @@
 			};
 		};
 
-		aips2: aips-bus at 02100000 {
+		aips2: aips-bus at 2100000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x02100000 0x100000>;
 			ranges;
 
-			usbotg1: usb at 02184000 {
+			usbotg1: usb at 2184000 {
 				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
 				reg = <0x02184000 0x200>;
 				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
@@ -753,7 +753,7 @@
 				status = "disabled";
 			};
 
-			usbotg2: usb at 02184200 {
+			usbotg2: usb at 2184200 {
 				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
 				reg = <0x02184200 0x200>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
@@ -766,13 +766,13 @@
 				status = "disabled";
 			};
 
-			usbmisc: usbmisc at 02184800 {
+			usbmisc: usbmisc at 2184800 {
 				#index-cells = <1>;
 				compatible = "fsl,imx6ul-usbmisc", "fsl,imx6q-usbmisc";
 				reg = <0x02184800 0x200>;
 			};
 
-			fec1: ethernet at 02188000 {
+			fec1: ethernet at 2188000 {
 				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
@@ -789,7 +789,7 @@
 				status = "disabled";
 			};
 
-			usdhc1: usdhc at 02190000 {
+			usdhc1: usdhc at 2190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -801,7 +801,7 @@
 				status = "disabled";
 			};
 
-			usdhc2: usdhc at 02194000 {
+			usdhc2: usdhc at 2194000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -813,7 +813,7 @@
 				status = "disabled";
 			};
 
-			adc1: adc at 02198000 {
+			adc1: adc at 2198000 {
 				compatible = "fsl,imx6ul-adc", "fsl,vf610-adc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
@@ -825,7 +825,7 @@
 				status = "disabled";
 			};
 
-			i2c1: i2c at 021a0000 {
+			i2c1: i2c at 21a0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
@@ -835,7 +835,7 @@
 				status = "disabled";
 			};
 
-			i2c2: i2c at 021a4000 {
+			i2c2: i2c at 21a4000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
@@ -845,7 +845,7 @@
 				status = "disabled";
 			};
 
-			i2c3: i2c at 021a8000 {
+			i2c3: i2c at 21a8000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
@@ -855,18 +855,18 @@
 				status = "disabled";
 			};
 
-			mmdc: mmdc at 021b0000 {
+			mmdc: mmdc at 21b0000 {
 				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
 			};
 
-			ocotp: ocotp-ctrl at 021bc000 {
+			ocotp: ocotp-ctrl at 21bc000 {
 				compatible = "fsl,imx6ul-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6UL_CLK_OCOTP>;
 			};
 
-			lcdif: lcdif at 021c8000 {
+			lcdif: lcdif at 21c8000 {
 				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
 				reg = <0x021c8000 0x4000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -877,7 +877,7 @@
 				status = "disabled";
 			};
 
-			qspi: qspi at 021e0000 {
+			qspi: qspi at 21e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6ul-qspi", "fsl,imx6sx-qspi";
@@ -890,7 +890,7 @@
 				status = "disabled";
 			};
 
-			uart2: serial at 021e8000 {
+			uart2: serial at 21e8000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
 				reg = <0x021e8000 0x4000>;
@@ -901,7 +901,7 @@
 				status = "disabled";
 			};
 
-			uart3: serial at 021ec000 {
+			uart3: serial at 21ec000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
 				reg = <0x021ec000 0x4000>;
@@ -912,7 +912,7 @@
 				status = "disabled";
 			};
 
-			uart4: serial at 021f0000 {
+			uart4: serial at 21f0000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
 				reg = <0x021f0000 0x4000>;
@@ -923,7 +923,7 @@
 				status = "disabled";
 			};
 
-			uart5: serial at 021f4000 {
+			uart5: serial at 21f4000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
 				reg = <0x021f4000 0x4000>;
@@ -934,7 +934,7 @@
 				status = "disabled";
 			};
 
-			i2c4: i2c at 021f8000 {
+			i2c4: i2c at 21f8000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
@@ -944,7 +944,7 @@
 				status = "disabled";
 			};
 
-			uart6: serial at 021fc000 {
+			uart6: serial at 21fc000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
 				reg = <0x021fc000 0x4000>;
-- 
2.7.4
