From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Feb 2018 20:22:46 +0100
Subject: [PATCH] ARM: dts: imx: Add support for Advantech DMS-BA16
In-Reply-To: <20180204184514.2396-1-yungching0725@gmail.com>
References: <20180204184514.2396-1-yungching0725@gmail.com>
Message-ID: <20180204192246.GC24569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 02:45:14AM +0800, Ken Lin wrote:
> Add support for Advantech DMS-BA16 board, which use
> the Advantech BA-16 module.
> 
> Signed-off-by: Ken Lin <yungching0725@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx6q-dms-ba16.dts | 154 +++++++++++++++++++++++++++++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..d97511273f30 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -428,6 +428,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-b450v3.dtb \
>  	imx6q-b650v3.dtb \
>  	imx6q-b850v3.dtb \
> +	imx6q-dms-ba16.dtb \
>  	imx6q-cm-fx6.dtb \
>  	imx6q-cubox-i.dtb \
>  	imx6q-cubox-i-emmc-som-v15.dtb \

Hi Ken

I think the intention is to keep this list sorted. So dms puts it
later, after cubox.

> @@ -0,0 +1,154 @@
> +/*
> + * Copyright 2018 Advantech Corporation
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx6q-ba16.dtsi"
> +
> +/ {
> +	model = "Advantech DMS-BA16";
> +	compatible = "fsl,imx6q-dms-ba16", "fsl,imx6q";

This looks wrong. I would expect "advantech,imx6q-dms-ba16".

     Andrew
