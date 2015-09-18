From: gaopan@freescale.com (Gao Pandy)
Date: Fri, 18 Sep 2015 07:39:05 +0000
Subject: [Patch V5] ARM: dts: imx6qdl-sabresd: add i2c pinctrl gpio state
 for bus recovery
In-Reply-To: <1441968155-10918-2-git-send-email-b54642@freescale.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <1441968155-10918-2-git-send-email-b54642@freescale.com>
Message-ID: <CY1PR0301MB0858EFF5EA41BBD2D309AB08CF590@CY1PR0301MB0858.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...
From: Gao Pan <mailto:b54642@freescale.com> Sent: Friday, September 11, 2015 6:43 PM
> To: wsa at the-dreams.de; u.kleine-koenig at pengutronix.de;
> shawnguo at kernel.org; kernel at pengutronix.de
> Cc: linux-i2c at vger.kernel.org; Li Frank-B20596; Duan Fugang-B38611; Gao
> Pan-B54642; linux-arm-kernel at lists.infradead.org
> Subject: [Patch V5] ARM: dts: imx6qdl-sabresd: add i2c pinctrl gpio state
> for bus recovery
> 
> When i2c bus SCL/SDA are stuck low during transfer, the i2c pinctrl
> should be configured to gpio mode to do bus recovery.
> 
> Genenally, we can use sleep state for bus recovery. But it's not a good
> choice to use sleep state here because it will be confused. This patch
> introduces a dedicated gpio state.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 944eb81..6e97018 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -172,8 +172,11 @@
> 
>  &i2c1 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio5 26 0>;
> +	sda-gpios = <&gpio5 27 0>;
>  	status = "okay";
> 
>  	codec: wm8962 at 1a {
> @@ -393,6 +396,13 @@
>  			>;
>  		};
> 
> +		pinctrl_i2c1_gpio: i2c1grp_gpio {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26        0x1b0b0
> +				MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27        0x1b0b0
> +			>
> +		};
> +
>  		pinctrl_i2c2: i2c2grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
> --
> 1.9.1
