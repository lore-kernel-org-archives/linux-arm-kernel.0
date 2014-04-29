From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 12:55:07 +0800
Subject: [PATCH] ARM: dts: imx53-qsb-common: Add TVE support
In-Reply-To: <1398254769-10513-1-git-send-email-festevam@gmail.com>
References: <1398254769-10513-1-git-send-email-festevam@gmail.com>
Message-ID: <20140429045504.GA16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:06:09AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx53-qsb-common.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
> index ede04fa..a491bde 100644
> --- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
> +++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
> @@ -272,6 +272,14 @@
>  			>;
>  		};
>  
> +		pinctrl_vga_sync_1: vgasync-grp1 {

Will there be pinctrl_vga_sync_2, pinctrl_vga_sync_3, ...?  Otherwise, I
see no point to have the number suffix in there?

Shawn

> +			fsl,pins = <
> +				/* VGA_HSYNC, VSYNC with max drive strength */
> +				MX53_PAD_EIM_OE__IPU_DI1_PIN7 0xe6
> +				MX53_PAD_EIM_RW__IPU_DI1_PIN8 0xe6
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX53_PAD_CSI0_DAT10__UART1_TXD_MUX	0x1e4
> @@ -281,6 +289,15 @@
>  	};
>  };
>  
> +&tve {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_vga_sync_1>;
> +	fsl,tve-mode = "vga";
> +	fsl,hsync-pin = <4>;
> +	fsl,vsync-pin = <6>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -- 
> 1.8.3.2
> 
> 
> 
