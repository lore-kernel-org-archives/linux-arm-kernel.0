From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 May 2013 10:56:32 +0200
Subject: [PATCH V2 2/2] ARM/DTS/MVF600: add basic device tree source for
 Vybrid
In-Reply-To: <1367480285-26159-3-git-send-email-b35083@freescale.com>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-3-git-send-email-b35083@freescale.com>
Message-ID: <20130502085632.GP32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:38:05PM +0800, Jingchang Lu wrote:
> This patch adds basic device tree source for Freescale
> Vybrid Family MVF600 platform and Tower development board.
> 
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> V2:
>   Add pinctrl support based on IMX new pinctrl framework
> 
>  arch/arm/boot/dts/Makefile         |   3 +-
>  arch/arm/boot/dts/mvf600-pinfunc.h | 816 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mvf600-twr.dts   |  80 ++++
>  arch/arm/boot/dts/mvf600.dtsi      | 426 +++++++++++++++++++
>  4 files changed, 1324 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/mvf600-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/mvf600-twr.dts
>  create mode 100644 arch/arm/boot/dts/mvf600.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8fd41b3..6402f21 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -119,7 +119,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
>  	imx6q-sabresd.dtb \
> -	imx6q-sbc6x.dtb
> +	imx6q-sbc6x.dtb \
> +	mvf600-twr.dtb
>  dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx23-olinuxino.dtb \
>  	imx23-stmp378x_devb.dtb \
> diff --git a/arch/arm/boot/dts/mvf600-pinfunc.h b/arch/arm/boot/dts/mvf600-pinfunc.h
> new file mode 100644
> index 0000000..9fbc7a9
> --- /dev/null
> +++ b/arch/arm/boot/dts/mvf600-pinfunc.h
> @@ -0,0 +1,816 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DTS_MVF600_PINFUNC_H
> +#define __DTS_MVF600_PINFUNC_H
> +
> +/*
> + * Macro definations for MVF600 pin functions

s/definations/definitions/

> diff --git a/arch/arm/boot/dts/mvf600-twr.dts b/arch/arm/boot/dts/mvf600-twr.dts

Make this a separate patch please. It's board specific whereas the rest
is SoC specific.

> +		aips1: aips-bus at 40080000 { /* AIPS1 */
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40080000 0x80000>;
> +			ranges;
> +
> +			uart4: serial at 400a9000 { /* UART4 */
> +				compatible = "fsl,mvf-uart";
> +				reg = <0x400a9000 0x1000>;
> +				interrupts = <0 65 0x04>;
> +				clocks = <&clks 43>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			uart5: serial at 400aa000 { /* UART5 */
> +				compatible = "fsl,mvf-uart";
> +				reg = <0x400aa000 0x1000>;
> +				interrupts = <0 66 0x04>;
> +				clocks = <&clks 44>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			fec0: ethernet at 400d0000 {
> +				compatible = "fsl,mvf-fec";
> +				reg = <0x400d0000 0x1000>;
> +				interrupts = <0 78 0x04>;
> +				clocks = <&clks 69>, <&clks 69>, <&clks 69>;
> +				clock-names = "ipg", "ahb", "ptp";

				status = "disabled";

> +			};
> +
> +			fec1: ethernet at 400d1000 {
> +				compatible = "fsl,mvf-fec";
> +				reg = <0x400d1000 0x1000>;
> +				interrupts = <0 79 0x04>;
> +				clocks = <&clks 69>, <&clks 69>, <&clks 69>;
> +				clock-names = "ipg", "ahb", "ptp";

				status = "disabled";

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
