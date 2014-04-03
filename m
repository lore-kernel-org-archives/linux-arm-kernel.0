From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Apr 2014 10:01:38 +0800
Subject: [PATCH 2/3] ARM: dts: imx27-pdk: Pass the UART1 pin configuration
In-Reply-To: <1396477546-11130-2-git-send-email-festevam@gmail.com>
References: <1396477546-11130-1-git-send-email-festevam@gmail.com>
 <1396477546-11130-2-git-send-email-festevam@gmail.com>
Message-ID: <20140403020137.GC2786@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 07:25:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Provide an entry for the UART1 pin muxing.
> 
> While at it, sort the dt entries.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27-pdk.dts | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
> index 28c83bc..5e9a4bb 100644
> --- a/arch/arm/boot/dts/imx27-pdk.dts
> +++ b/arch/arm/boot/dts/imx27-pdk.dts
> @@ -21,11 +21,27 @@
>  	};
>  };
>  
> -&uart1 {
> -	fsl,uart-has-rtscts;
> +&fec {
>  	status = "okay";
>  };
>  
> -&fec {
> +
> +&iomuxc {

The iomuxc node in board dts is a little special now, and it will have a
lot more data than others.  I like Alexander's idea to put it at the
bottom of the file to make it easier for users to check board level
settings of other device nodes.  So I would suggest that way for the new
added iomuxc node in board dts.

Shawn

> +	imx27-pdk {
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX27_PAD_UART1_TXD__UART1_TXD 0x0
> +				MX27_PAD_UART1_RXD__UART1_RXD 0x0
> +				MX27_PAD_UART1_CTS__UART1_CTS 0x0
> +				MX27_PAD_UART1_RTS__UART1_RTS 0x0
> +			>;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	fsl,uart-has-rtscts;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
>  	status = "okay";
>  };
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
