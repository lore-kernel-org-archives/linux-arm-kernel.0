From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Nov 2012 21:48:33 +0800
Subject: [PATCH] ARM i.MX dts: Consistently add labels to devicenodes
In-Reply-To: <1352968312-8321-1-git-send-email-s.hauer@pengutronix.de>
References: <1352968312-8321-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20121115134831.GA2546@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 09:31:52AM +0100, Sascha Hauer wrote:
> Having labels before each node allows board bindings to reference
> to nodes by using the &nodename {} notation.

I can understand this part.

> This way boards do not
> have to resemble the whole devicetree layout. Due to less indention
> needed the board files also get better readability.

I do not understand it.  Don't we have to always maintain the device
tree layout defined by <soc>.dtsi in <board>.dts, do we?

> Since the label
> make the documentation behind the nodes unnecessary it is removed.
> 
I can also understand this part.

Shawn

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi |    5 ++-
>  arch/arm/boot/dts/imx51.dtsi |   40 +++++++++----------
>  arch/arm/boot/dts/imx53.dtsi |   42 ++++++++++----------
>  arch/arm/boot/dts/imx6q.dtsi |   88 +++++++++++++++++++++---------------------
>  4 files changed, 88 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 3e54f14..4192e87 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -58,7 +58,7 @@
>  			reg = <0x10000000 0x10000000>;
>  			ranges;
>  
> -			wdog at 10002000 {
> +			wdog: wdog at 10002000 {
>  				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
>  				reg = <0x10002000 0x4000>;
>  				interrupts = <27>;
> @@ -218,7 +218,8 @@
>  				status = "disabled";
>  			};
>  		};
> -		nand at d8000000 {
> +
> +		nfc: nand at d8000000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 75d069f..9fd7657 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -76,14 +76,14 @@
>  				reg = <0x70000000 0x40000>;
>  				ranges;
>  
> -				esdhc at 70004000 { /* ESDHC1 */
> +				esdhc1: esdhc at 70004000 {
>  					compatible = "fsl,imx51-esdhc";
>  					reg = <0x70004000 0x4000>;
>  					interrupts = <1>;
>  					status = "disabled";
>  				};
>  
> -				esdhc at 70008000 { /* ESDHC2 */
> +				esdhc2: esdhc at 70008000 {
>  					compatible = "fsl,imx51-esdhc";
>  					reg = <0x70008000 0x4000>;
>  					interrupts = <2>;
> @@ -97,7 +97,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 70010000 { /* ECSPI1 */
> +				ecspi1: ecspi at 70010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx51-ecspi";
> @@ -115,14 +115,14 @@
>  					status = "disabled";
>  				};
>  
> -				esdhc at 70020000 { /* ESDHC3 */
> +				esdhc3: esdhc at 70020000 {
>  					compatible = "fsl,imx51-esdhc";
>  					reg = <0x70020000 0x4000>;
>  					interrupts = <3>;
>  					status = "disabled";
>  				};
>  
> -				esdhc at 70024000 { /* ESDHC4 */
> +				esdhc4: esdhc at 70024000 {
>  					compatible = "fsl,imx51-esdhc";
>  					reg = <0x70024000 0x4000>;
>  					interrupts = <4>;
> @@ -130,28 +130,28 @@
>  				};
>  			};
>  
> -			usb at 73f80000 {
> +			usbotg: usb at 73f80000 {
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80000 0x0200>;
>  				interrupts = <18>;
>  				status = "disabled";
>  			};
>  
> -			usb at 73f80200 {
> +			usbh1: usb at 73f80200 {
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80200 0x0200>;
>  				interrupts = <14>;
>  				status = "disabled";
>  			};
>  
> -			usb at 73f80400 {
> +			usbh2: usb at 73f80400 {
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80400 0x0200>;
>  				interrupts = <16>;
>  				status = "disabled";
>  			};
>  
> -			usb at 73f80600 {
> +			usbh3: usb at 73f80600 {
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80600 0x0200>;
>  				interrupts = <17>;
> @@ -198,20 +198,20 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> -			wdog at 73f98000 { /* WDOG1 */
> +			wdog1: wdog at 73f98000 {
>  				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
>  				reg = <0x73f98000 0x4000>;
>  				interrupts = <58>;
>  			};
>  
> -			wdog at 73f9c000 { /* WDOG2 */
> +			wdog2: wdog at 73f9c000 {
>  				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
>  				reg = <0x73f9c000 0x4000>;
>  				interrupts = <59>;
>  				status = "disabled";
>  			};
>  
> -			iomuxc at 73fa8000 {
> +			iomuxc: iomuxc at 73fa8000 {
>  				compatible = "fsl,imx51-iomuxc";
>  				reg = <0x73fa8000 0x4000>;
>  
> @@ -349,7 +349,7 @@
>  			reg = <0x80000000 0x10000000>;
>  			ranges;
>  
> -			ecspi at 83fac000 { /* ECSPI2 */
> +			ecspi2: ecspi at 83fac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-ecspi";
> @@ -358,14 +358,14 @@
>  				status = "disabled";
>  			};
>  
> -			sdma at 83fb0000 {
> +			sdma: sdma at 83fb0000 {
>  				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
>  				reg = <0x83fb0000 0x4000>;
>  				interrupts = <6>;
>  				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
>  			};
>  
> -			cspi at 83fc0000 {
> +			cspi: cspi at 83fc0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
> @@ -374,7 +374,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 83fc4000 { /* I2C2 */
> +			i2c2: i2c at 83fc4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
> @@ -383,7 +383,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 83fc8000 { /* I2C1 */
> +			i2c1: i2c at 83fc8000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
> @@ -401,13 +401,13 @@
>  				status = "disabled";
>  			};
>  
> -			audmux at 83fd0000 {
> +			audmux: audmux at 83fd0000 {
>  				compatible = "fsl,imx51-audmux", "fsl,imx31-audmux";
>  				reg = <0x83fd0000 0x4000>;
>  				status = "disabled";
>  			};
>  
> -			nand at 83fdb000 {
> +			nfc: nand at 83fdb000 {
>  				compatible = "fsl,imx51-nand";
>  				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
>  				interrupts = <8>;
> @@ -423,7 +423,7 @@
>  				status = "disabled";
>  			};
>  
> -			ethernet at 83fec000 {
> +			fec: ethernet at 83fec000 {
>  				compatible = "fsl,imx51-fec", "fsl,imx27-fec";
>  				reg = <0x83fec000 0x4000>;
>  				interrupts = <87>;
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 76ebb1a..08effd1 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -81,14 +81,14 @@
>  				reg = <0x50000000 0x40000>;
>  				ranges;
>  
> -				esdhc at 50004000 { /* ESDHC1 */
> +				esdhc1: esdhc at 50004000 {
>  					compatible = "fsl,imx53-esdhc";
>  					reg = <0x50004000 0x4000>;
>  					interrupts = <1>;
>  					status = "disabled";
>  				};
>  
> -				esdhc at 50008000 { /* ESDHC2 */
> +				esdhc2: esdhc at 50008000 {
>  					compatible = "fsl,imx53-esdhc";
>  					reg = <0x50008000 0x4000>;
>  					interrupts = <2>;
> @@ -102,7 +102,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 50010000 { /* ECSPI1 */
> +				ecspi1: ecspi at 50010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
> @@ -120,14 +120,14 @@
>  					status = "disabled";
>  				};
>  
> -				esdhc at 50020000 { /* ESDHC3 */
> +				esdhc3: esdhc at 50020000 {
>  					compatible = "fsl,imx53-esdhc";
>  					reg = <0x50020000 0x4000>;
>  					interrupts = <3>;
>  					status = "disabled";
>  				};
>  
> -				esdhc at 50024000 { /* ESDHC4 */
> +				esdhc4: esdhc at 50024000 {
>  					compatible = "fsl,imx53-esdhc";
>  					reg = <0x50024000 0x4000>;
>  					interrupts = <4>;
> @@ -135,28 +135,28 @@
>  				};
>  			};
>  
> -			usb at 53f80000 {
> +			usbotg: usb at 53f80000 {
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80000 0x0200>;
>  				interrupts = <18>;
>  				status = "disabled";
>  			};
>  
> -			usb at 53f80200 {
> +			usbh1: usb at 53f80200 {
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80200 0x0200>;
>  				interrupts = <14>;
>  				status = "disabled";
>  			};
>  
> -			usb at 53f80400 {
> +			usbh2: usb at 53f80400 {
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80400 0x0200>;
>  				interrupts = <16>;
>  				status = "disabled";
>  			};
>  
> -			usb at 53f80600 {
> +			usbh3: usb at 53f80600 {
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80600 0x0200>;
>  				interrupts = <17>;
> @@ -203,20 +203,20 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> -			wdog at 53f98000 { /* WDOG1 */
> +			wdog1: wdog at 53f98000 {
>  				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
>  				reg = <0x53f98000 0x4000>;
>  				interrupts = <58>;
>  			};
>  
> -			wdog at 53f9c000 { /* WDOG2 */
> +			wdog2: wdog at 53f9c000 {
>  				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
>  				reg = <0x53f9c000 0x4000>;
>  				interrupts = <59>;
>  				status = "disabled";
>  			};
>  
> -			iomuxc at 53fa8000 {
> +			iomuxc: iomuxc at 53fa8000 {
>  				compatible = "fsl,imx53-iomuxc";
>  				reg = <0x53fa8000 0x4000>;
>  
> @@ -429,7 +429,7 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> -			i2c at 53fec000 { /* I2C3 */
> +			i2c3: i2c at 53fec000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
> @@ -460,7 +460,7 @@
>  				status = "disabled";
>  			};
>  
> -			ecspi at 63fac000 { /* ECSPI2 */
> +			ecspi2: ecspi at 63fac000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
> @@ -469,14 +469,14 @@
>  				status = "disabled";
>  			};
>  
> -			sdma at 63fb0000 {
> +			sdma: sdma at 63fb0000 {
>  				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
>  				reg = <0x63fb0000 0x4000>;
>  				interrupts = <6>;
>  				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
>  			};
>  
> -			cspi at 63fc0000 {
> +			cspi: cspi at 63fc0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
> @@ -485,7 +485,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 63fc4000 { /* I2C2 */
> +			i2c2: i2c at 63fc4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
> @@ -494,7 +494,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 63fc8000 { /* I2C1 */
> +			i2c1: i2c at 63fc8000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
> @@ -512,13 +512,13 @@
>  				status = "disabled";
>  			};
>  
> -			audmux at 63fd0000 {
> +			audmux: audmux at 63fd0000 {
>  				compatible = "fsl,imx53-audmux", "fsl,imx31-audmux";
>  				reg = <0x63fd0000 0x4000>;
>  				status = "disabled";
>  			};
>  
> -			nand at 63fdb000 {
> +			nfc: nand at 63fdb000 {
>  				compatible = "fsl,imx53-nand";
>  				reg = <0x63fdb000 0x1000 0xf7ff0000 0x10000>;
>  				interrupts = <8>;
> @@ -534,7 +534,7 @@
>  				status = "disabled";
>  			};
>  
> -			ethernet at 63fec000 {
> +			fec: ethernet at 63fec000 {
>  				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
>  				reg = <0x63fec000 0x4000>;
>  				interrupts = <87>;
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index f3990b0..56772b9 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -100,7 +100,7 @@
>  			clocks = <&clks 106>;
>  		};
>  
> -		gpmi-nand at 00112000 {
> +		nfc: gpmi-nand at 00112000 {
>  			compatible = "fsl,imx6q-gpmi-nand";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -144,12 +144,12 @@
>  				reg = <0x02000000 0x40000>;
>  				ranges;
>  
> -				spdif at 02004000 {
> +				spdif: spdif at 02004000 {
>  					reg = <0x02004000 0x4000>;
>  					interrupts = <0 52 0x04>;
>  				};
>  
> -				ecspi at 02008000 { /* eCSPI1 */
> +				ecspi1: ecspi at 02008000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -160,7 +160,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 0200c000 { /* eCSPI2 */
> +				ecspi2: ecspi at 0200c000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -171,7 +171,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 02010000 { /* eCSPI3 */
> +				ecspi3: ecspi at 02010000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -182,7 +182,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 02014000 { /* eCSPI4 */
> +				ecspi4: ecspi at 02014000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -193,7 +193,7 @@
>  					status = "disabled";
>  				};
>  
> -				ecspi at 02018000 { /* eCSPI5 */
> +				ecspi5: ecspi at 02018000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> @@ -213,7 +213,7 @@
>  					status = "disabled";
>  				};
>  
> -				esai at 02024000 {
> +				esai: esai at 02024000 {
>  					reg = <0x02024000 0x4000>;
>  					interrupts = <0 51 0x04>;
>  				};
> @@ -248,7 +248,7 @@
>  					status = "disabled";
>  				};
>  
> -				asrc at 02034000 {
> +				asrc: asrc at 02034000 {
>  					reg = <0x02034000 0x4000>;
>  					interrupts = <0 50 0x04>;
>  				};
> @@ -258,7 +258,7 @@
>  				};
>  			};
>  
> -			vpu at 02040000 {
> +			vpu: vpu at 02040000 {
>  				reg = <0x02040000 0x3c000>;
>  				interrupts = <0 3 0x04 0 12 0x04>;
>  			};
> @@ -267,37 +267,37 @@
>  				reg = <0x0207c000 0x4000>;
>  			};
>  
> -			pwm at 02080000 { /* PWM1 */
> +			pwm1: pwm at 02080000 {
>  				reg = <0x02080000 0x4000>;
>  				interrupts = <0 83 0x04>;
>  			};
>  
> -			pwm at 02084000 { /* PWM2 */
> +			pwm2: pwm at 02084000 {
>  				reg = <0x02084000 0x4000>;
>  				interrupts = <0 84 0x04>;
>  			};
>  
> -			pwm at 02088000 { /* PWM3 */
> +			pwm3: pwm at 02088000 {
>  				reg = <0x02088000 0x4000>;
>  				interrupts = <0 85 0x04>;
>  			};
>  
> -			pwm at 0208c000 { /* PWM4 */
> +			pwm4: pwm at 0208c000 {
>  				reg = <0x0208c000 0x4000>;
>  				interrupts = <0 86 0x04>;
>  			};
>  
> -			flexcan at 02090000 { /* CAN1 */
> +			can1: flexcan at 02090000 {
>  				reg = <0x02090000 0x4000>;
>  				interrupts = <0 110 0x04>;
>  			};
>  
> -			flexcan at 02094000 { /* CAN2 */
> +			can2: flexcan at 02094000 {
>  				reg = <0x02094000 0x4000>;
>  				interrupts = <0 111 0x04>;
>  			};
>  
> -			gpt at 02098000 {
> +			gpt: gpt at 02098000 {
>  				compatible = "fsl,imx6q-gpt";
>  				reg = <0x02098000 0x4000>;
>  				interrupts = <0 55 0x04>;
> @@ -373,19 +373,19 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> -			kpp at 020b8000 {
> +			kpp: kpp at 020b8000 {
>  				reg = <0x020b8000 0x4000>;
>  				interrupts = <0 82 0x04>;
>  			};
>  
> -			wdog at 020bc000 { /* WDOG1 */
> +			wdog1: wdog at 020bc000 {
>  				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
>  				reg = <0x020bc000 0x4000>;
>  				interrupts = <0 80 0x04>;
>  				clocks = <&clks 0>;
>  			};
>  
> -			wdog at 020c0000 { /* WDOG2 */
> +			wdog2: wdog at 020c0000 {
>  				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
>  				reg = <0x020c0000 0x4000>;
>  				interrupts = <0 81 0x04>;
> @@ -509,23 +509,23 @@
>  				interrupts = <0 19 0x04 0 20 0x04>;
>  			};
>  
> -			epit at 020d0000 { /* EPIT1 */
> +			epit1: epit at 020d0000 { /* EPIT1 */
>  				reg = <0x020d0000 0x4000>;
>  				interrupts = <0 56 0x04>;
>  			};
>  
> -			epit at 020d4000 { /* EPIT2 */
> +			epit2: epit at 020d4000 { /* EPIT2 */
>  				reg = <0x020d4000 0x4000>;
>  				interrupts = <0 57 0x04>;
>  			};
>  
> -			src at 020d8000 {
> +			src: src at 020d8000 {
>  				compatible = "fsl,imx6q-src";
>  				reg = <0x020d8000 0x4000>;
>  				interrupts = <0 91 0x04 0 96 0x04>;
>  			};
>  
> -			gpc at 020dc000 {
> +			gpc: gpc at 020dc000 {
>  				compatible = "fsl,imx6q-gpc";
>  				reg = <0x020dc000 0x4000>;
>  				interrupts = <0 89 0x04 0 90 0x04>;
> @@ -536,7 +536,7 @@
>  				reg = <0x020e0000 0x38>;
>  			};
>  
> -			iomuxc at 020e0000 {
> +			iomuxc: iomuxc at 020e0000 {
>  				compatible = "fsl,imx6q-iomuxc";
>  				reg = <0x020e0000 0x4000>;
>  
> @@ -748,17 +748,17 @@
>  				};
>  			};
>  
> -			dcic at 020e4000 { /* DCIC1 */
> +			dcic1: dcic at 020e4000 {
>  				reg = <0x020e4000 0x4000>;
>  				interrupts = <0 124 0x04>;
>  			};
>  
> -			dcic at 020e8000 { /* DCIC2 */
> +			dcic2: dcic at 020e8000 {
>  				reg = <0x020e8000 0x4000>;
>  				interrupts = <0 125 0x04>;
>  			};
>  
> -			sdma at 020ec000 {
> +			sdma: sdma at 020ec000 {
>  				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
>  				reg = <0x020ec000 0x4000>;
>  				interrupts = <0 2 0x04>;
> @@ -784,7 +784,7 @@
>  				reg = <0x0217c000 0x4000>;
>  			};
>  
> -			usb at 02184000 { /* USB OTG */
> +			usbotg: usb at 02184000 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184000 0x200>;
>  				interrupts = <0 43 0x04>;
> @@ -794,7 +794,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb at 02184200 { /* USB1 */
> +			usbh1: usb at 02184200 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184200 0x200>;
>  				interrupts = <0 40 0x04>;
> @@ -804,7 +804,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb at 02184400 { /* USB2 */
> +			usbh2: usb at 02184400 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 41 0x04>;
> @@ -813,7 +813,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb at 02184600 { /* USB3 */
> +			usbh3: usb at 02184600 {
>  				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
>  				reg = <0x02184600 0x200>;
>  				interrupts = <0 42 0x04>;
> @@ -822,14 +822,14 @@
>  				status = "disabled";
>  			};
>  
> -			usbmisc: usbmisc at 02184800 {
> +			usbmisc: usbmisc: usbmisc at 02184800 {
>  				#index-cells = <1>;
>  				compatible = "fsl,imx6q-usbmisc";
>  				reg = <0x02184800 0x200>;
>  				clocks = <&clks 162>;
>  			};
>  
> -			ethernet at 02188000 {
> +			fec: ethernet at 02188000 {
>  				compatible = "fsl,imx6q-fec";
>  				reg = <0x02188000 0x4000>;
>  				interrupts = <0 118 0x04 0 119 0x04>;
> @@ -843,7 +843,7 @@
>  				interrupts = <0 53 0x04 0 117 0x04 0 126 0x04>;
>  			};
>  
> -			usdhc at 02190000 { /* uSDHC1 */
> +			usdhc1: usdhc at 02190000 {
>  				compatible = "fsl,imx6q-usdhc";
>  				reg = <0x02190000 0x4000>;
>  				interrupts = <0 22 0x04>;
> @@ -852,7 +852,7 @@
>  				status = "disabled";
>  			};
>  
> -			usdhc at 02194000 { /* uSDHC2 */
> +			usdhc2: usdhc at 02194000 {
>  				compatible = "fsl,imx6q-usdhc";
>  				reg = <0x02194000 0x4000>;
>  				interrupts = <0 23 0x04>;
> @@ -861,7 +861,7 @@
>  				status = "disabled";
>  			};
>  
> -			usdhc at 02198000 { /* uSDHC3 */
> +			usdhc3: usdhc at 02198000 {
>  				compatible = "fsl,imx6q-usdhc";
>  				reg = <0x02198000 0x4000>;
>  				interrupts = <0 24 0x04>;
> @@ -870,7 +870,7 @@
>  				status = "disabled";
>  			};
>  
> -			usdhc at 0219c000 { /* uSDHC4 */
> +			usdhc4: usdhc at 0219c000 {
>  				compatible = "fsl,imx6q-usdhc";
>  				reg = <0x0219c000 0x4000>;
>  				interrupts = <0 25 0x04>;
> @@ -879,7 +879,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 021a0000 { /* I2C1 */
> +			i2c1: i2c at 021a0000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
> @@ -889,7 +889,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 021a4000 { /* I2C2 */
> +			i2c2: i2c at 021a4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
> @@ -899,7 +899,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 021a8000 { /* I2C3 */
> +			i2c3: i2c at 021a8000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
> @@ -913,12 +913,12 @@
>  				reg = <0x021ac000 0x4000>;
>  			};
>  
> -			mmdc at 021b0000 { /* MMDC0 */
> +			mmdc0: mmdc at 021b0000 { /* MMDC0 */
>  				compatible = "fsl,imx6q-mmdc";
>  				reg = <0x021b0000 0x4000>;
>  			};
>  
> -			mmdc at 021b4000 { /* MMDC1 */
> +			mmdc1: mmdc at 021b4000 { /* MMDC1 */
>  				reg = <0x021b4000 0x4000>;
>  			};
>  
> @@ -946,7 +946,7 @@
>  				interrupts = <0 109 0x04>;
>  			};
>  
> -			audmux at 021d8000 {
> +			audmux: audmux at 021d8000 {
>  				compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
>  				reg = <0x021d8000 0x4000>;
>  				status = "disabled";
> -- 
> 1.7.10.4
> 
