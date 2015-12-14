From: robh@kernel.org (Rob Herring)
Date: Sun, 13 Dec 2015 19:25:06 -0600
Subject: [PATCH 2/5] ARM: dts: cm-t335: add support for SBC-T335
In-Reply-To: <1449996939-13901-3-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-3-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <20151214012506.GA11251@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2015 at 10:55:36AM +0200, Uri Mashiach wrote:
> Add basic support for the SBC-T335.
> 
> CompuLab SBC-T335 is a single baseboard computer.
> The SBC-T335 is based on the Texas Instruments Cortex-A8 Sitara AM3354
> SoC.
> 
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt |  3 +++
>  arch/arm/boot/dts/Makefile                          |  1 +
>  arch/arm/boot/dts/am335x-sbc-t335.dts               | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-sbc-t335.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 2154f97..358e87e 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -141,6 +141,9 @@ Boards:
>  - AM335X CM-T335 : System On Module, built around the Sitara AM3352/4
>    compatible = "compulab,cm-t335", "ti,am33xx"
>  
> +- AM335X SBC-T335 : single board computer, built around the Sitara AM3352/4
> +  compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx"
> +
>  - OMAP5 EVM : Evaluation Module
>    compatible = "ti,omap5-evm", "ti,omap5"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 15411bc..d82ea97 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -466,6 +466,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>  	am335x-lxm.dtb \
>  	am335x-nano.dtb \
>  	am335x-pepper.dtb \
> +	am335x-sbc-t335.dtb \
>  	am335x-sl50.dtb \
>  	am335x-wega-rdk.dtb
>  dtb-$(CONFIG_ARCH_OMAP4) += \
> diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
> new file mode 100644
> index 0000000..9e98445
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
> @@ -0,0 +1,16 @@
> +/*
> + * am335x-sbc-t335.dts - Device Tree file for Compulab SBC-T335
> + *
> + * Copyright (C) 2014 - 2015 CompuLab Ltd. - http://www.compulab.co.il/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "am335x-cm-t335.dts"
> +
> +/ {
> +	model = "CompuLab CM-T335 on SB-T335";
> +	compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx";
> +};
> -- 
> 2.5.0
> 
