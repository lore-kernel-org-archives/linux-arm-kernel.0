From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Aug 2013 20:18:58 +0800
Subject: [PATCH 3/3] ARM: dts: i.MX51: Separate TXD/RXD and RTS/CTS
 pinmux entries for UARTs
In-Reply-To: <1376471153-3452-3-git-send-email-shc_work@mail.ru>
References: <1376471153-3452-1-git-send-email-shc_work@mail.ru>
 <1376471153-3452-3-git-send-email-shc_work@mail.ru>
Message-ID: <20130815121855.GJ16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 01:05:53PM +0400, Alexander Shiyan wrote:
> RTS/CTS pins can be used for different purposes, so create separate
> definitions for these pins.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts |  2 +-
>  arch/arm/boot/dts/imx51.dtsi        | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 1d337d9..899f1ce 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -252,7 +252,7 @@
>  
>  &uart1 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart1_1>;
> +	pinctrl-0 = <&pinctrl_uart1_1 &pinctrl_uart1_rtscts1>;
>  	fsl,uart-has-rtscts;
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index a85abb4..f8fa106 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -747,6 +747,11 @@
>  			fsl,pins = <
>  				MX51_PAD_UART1_RXD__UART1_RXD 0x1c5
>  				MX51_PAD_UART1_TXD__UART1_TXD 0x1c5
> +			>;
> +		};
> +
> +		pinctrl_uart1_rtscts1: uart1rtscts-1 {

Please follow the label name pattern to have it be pinctrl_uart1_rtscts_1.

> +			fsl,pins = <
>  				MX51_PAD_UART1_RTS__UART1_RTS 0x1c5
>  				MX51_PAD_UART1_CTS__UART1_CTS 0x1c5
>  			>;
> @@ -767,6 +772,11 @@
>  			fsl,pins = <
>  				MX51_PAD_EIM_D25__UART3_RXD 0x1c5
>  				MX51_PAD_EIM_D26__UART3_TXD 0x1c5
> +			>;
> +		};
> +
> +		pinctrl_uart3_rtscts1: uart3rtscts-1 {
> +			fsl,pins = <

I've seen pinctrl_uart3_1 has a consumer in imx51-babbage.dts, so you
need to update that.

Shawn

>  				MX51_PAD_EIM_D27__UART3_RTS 0x1c5
>  				MX51_PAD_EIM_D24__UART3_CTS 0x1c5
>  			>;
> -- 
> 1.8.1.5
> 
