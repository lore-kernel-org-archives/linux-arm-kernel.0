From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Jul 2013 15:57:37 +0800
Subject: [PATCH 2/2] ARM: dts: mx6: Add support for imx6dl nitrogen board
In-Reply-To: <1374118960-19060-2-git-send-email-festevam@gmail.com>
References: <1374118960-19060-1-git-send-email-festevam@gmail.com>
 <1374118960-19060-2-git-send-email-festevam@gmail.com>
Message-ID: <20130722075736.GC20271@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 12:42:40AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/imx6dl-nitrogen.dts | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index eeb2275..3f1a75d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx53-mba53.dtb \
>  	imx53-qsb.dtb \
>  	imx53-smd.dtb \
> +	imx6dl-nitrogen.dtb \
>  	imx6dl-sabreauto.dtb \
>  	imx6dl-sabresd.dtb \
>  	imx6dl-wandboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-nitrogen.dts b/arch/arm/boot/dts/imx6dl-nitrogen.dts
> new file mode 100644
> index 0000000..4f29207
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-nitrogen.dts
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * Author: Fabio Estevam <fabio.estevam@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-nitrogen.dtsi"
> +
> +/ {
> +	model = "Boundary Devices i.MX6 Dual Lite Nitrogen Board";
> +	compatible = "boundary,imx6dl-nitrogen", "fsl,imx6dl";
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};

This memory configuration is also common, right?

Shawn

> +};
> -- 
> 1.8.1.2
> 
