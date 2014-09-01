From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 1 Sep 2014 16:24:14 +0800
Subject: [PATCH v3] apf27dev: add max1027 in the dts
In-Reply-To: <1409517629-5918-1-git-send-email-tremyfr@gmail.com>
References: <1409517629-5918-1-git-send-email-tremyfr@gmail.com>
Message-ID: <20140901082413.GE3135@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 31, 2014 at 10:40:29PM +0200, Philippe Reynes wrote:
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> Changelog:
> v3: (thanks Alexander Shiyan for the feedback)
> - add datasheet pin name as comment
> 
> v2: (thanks Alexander Shiyan for the feedback)
> - spi mode 0 is the default so no need to explicitly define it
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index b982309..0c08fbb 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -82,6 +82,16 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
>  	status = "okay";
> +
> +	adc at 0 {
> +		compatible = "maxim,max1027";
> +		reg = <0>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_max1027>;
> +		spi-max-frequency = <10000000>;
> +	};
>  };
>  
>  &cspi2 {
> @@ -230,6 +240,13 @@
>  		pinctrl_sdhc2_cd: sdhc2cdgrp {
>  			fsl,pins = <MX27_PAD_TOUT__GPIO3_14 0x0>;
>  		};
> +
> +		pinctrl_max1027: max1027 {

The pinctrl entries are alphabetically sorted in there.  Can you also do
that for your addition?

> +			 fsl,pins = <
> +				 MX27_PAD_UART1_CTS__GPIO5_14 0 /* CNVST */
> +				 MX27_PAD_UART1_RTS__GPIO5_15 0 /* EOC */

Can you follow the convention to use hex value for the config cell,
i.e. s/0/0x0?

Shawn

> +			>;
> +		};
>  	};
>  };
>  
> -- 
> 1.7.4.4
> 
