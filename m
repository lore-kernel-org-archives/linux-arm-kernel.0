From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 17:15:19 +0800
Subject: [PATCH 4/5] ARM: dts: imx6: edmqmx6: Add can bus
In-Reply-To: <f93ea919813e2094b5592c88985ea85501da7f44.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
 <f93ea919813e2094b5592c88985ea85501da7f44.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <20140701091518.GJ14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:28:08PM +0200, Silvio Fricke wrote:
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> index b98fd74..8ead662 100644
> --- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> +++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> @@ -95,6 +95,12 @@
>  	};
>  };
>  
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +	status = "okay";
> +};
> +
>  &ecspi5 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi5>;
> @@ -300,6 +306,13 @@
>  			>;
>  		};
>  
> +		pinctrl_can1: can1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x80000000
> +				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x80000000

Same here.  Please configure the pads properly.

Shawn

> +			>;
> +		};
> +
>  		pinctrl_ecspi5: ecspi5rp-1 {
>  			fsl,pins = <
>  				MX6QDL_PAD_SD1_DAT0__ECSPI5_MISO	0x80000000
> -- 
> 2.0.0
> 
