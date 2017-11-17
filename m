From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Nov 2017 21:10:48 +0800
Subject: [PATCH 1/2] ARM: dts: Add the support for display5 equipped with
 Mitsubishi (800x480) display
In-Reply-To: <20171117102404.6678-1-lukma@denx.de>
References: <20171117102404.6678-1-lukma@denx.de>
Message-ID: <20171117131047.GE25390@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 11:24:03AM +0100, Lukasz Majewski wrote:
> This is the support for aa070mc01-ca1 Mitsubishi display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  .../imx6q-display5-mitsubishi-aa070-800x480.dts    | 51 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-display5-mitsubishi-aa070-800x480.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d9d0c82e7d20..10b3ad078dea 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -407,6 +407,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-cm-fx6.dtb \
>  	imx6q-cubox-i.dtb \
>  	imx6q-dfi-fs700-m60.dtb \
> +	imx6q-display5-mitsubishi-aa070-800x480.dtb \
>  	imx6q-display5-tianma-tm070-1280x768.dtb \
>  	imx6q-dmo-edmqmx6.dtb \
>  	imx6q-evi.dtb \

<snip>

> +#include "imx6q-display5.dtsi"
> +
> +&panel {
> +	compatible = "mitsubishi,aa070mc01-ca1";
> +};

How many DTB files do you want to add for this display5 board?  It's
obvious no fun to maintain a bunch of DTB files for all the panels this
board can support.  Let's stop right here.

Shawn

> +
> +&ldb {
> +	lvds0: lvds-channel at 0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <24>;
> +	};
> +};
> -- 
> 2.11.0
> 
