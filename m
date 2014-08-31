From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 31 Aug 2014 10:46:54 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gYXBmMjdkZXY6IGFkZCBtYXgxMDI3IGluIHRoZSBk?=
 =?UTF-8?B?dHM=?=
In-Reply-To: <1409436057-29729-1-git-send-email-tremyfr@gmail.com>
References: <1409436057-29729-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1409467614.685837886@f430.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sun, 31 Aug 2014 00:00:57 +0200 ?? Philippe Reynes <tremyfr@gmail.com>:
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> Changelog:
> v2: (thanks Alexander Shiyan for the feedback)
> - spi mode 0 is the default so no need to explicitly define it
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index b982309..f2bab73 100644
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
> +			 fsl,pins = <
> +				 MX27_PAD_UART1_CTS__GPIO5_14 0
> +				 MX27_PAD_UART1_RTS__GPIO5_15 0
> +			>;
> +		};
>  	};
>  };

Only one remark.
Function of GPIO5.14 is unclear. Can you add a comment for this?

---
