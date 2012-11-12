From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Nov 2012 10:41:45 +0800
Subject: [PATCH v2] ARM: mxs: apf28dev: Add I2C and SPI support
In-Reply-To: <1352464961-6414-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1352464961-6414-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20121112024144.GE415@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 01:42:41PM +0100, Gwenhael Goavec-Merou wrote:
> Changes since v1:
> 	- Removed the spidev support.

I'm not sure you want to have this in the final commit log, so I just
removed it and applied the patch.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---

Instead, any comment goes here (after ---) will not show up in the
final commit log when the patch gets applied with 'git am' command.

Shawn

>  arch/arm/boot/dts/imx28-apf28dev.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 1643d25..6d8865b 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -27,6 +27,13 @@
>  				status = "okay";
>  			};
>  
> +			ssp2: ssp at 80014000 {
> +				compatible = "fsl,imx28-spi";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&spi2_pins_a>;
> +				status = "okay";
> +			};
> +
>  			pinctrl at 80018000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&hog_pins_apf28dev>;
> @@ -74,6 +81,12 @@
>  				status = "okay";
>  			};
>  
> +			i2c0: i2c at 80058000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c0_pins_a>;
> +				status = "okay";
> +			};
> +
>  			pwm: pwm at 80064000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pwm3_pins_a &pwm4_pins_a>;
> -- 
> 1.7.8.6
> 
