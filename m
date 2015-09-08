From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 8 Sep 2015 15:06:14 +0530
Subject: [PATCH] ARM: omap2plus_defconfig: make PCF857x built-in
In-Reply-To: <1438782229-25118-1-git-send-email-kishon@ti.com>
References: <1438782229-25118-1-git-send-email-kishon@ti.com>
Message-ID: <55EEAC0E.3070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday 05 August 2015 07:13 PM, Kishon Vijay Abraham I wrote:
> One of the lines from PCF857x is connected to the vdd line of MMC1
> in DRA74x and DRA72x EVMs and is modelled as a regulator. If PCF857x
> is not made as built-in, the regulator_get in omap_hsmmc fails making
> it difficult to use MMC1 as rootfs.
> 
> Make PCF857x built-in.

Can this be picked for 4.3?

Thanks
Kishon

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ac521e7..7cedfe9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -236,7 +236,7 @@ CONFIG_SSI_PROTOCOL=m
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_GPIO_SYSFS=y
> -CONFIG_GPIO_PCF857X=m
> +CONFIG_GPIO_PCF857X=y
>  CONFIG_GPIO_TWL4030=y
>  CONFIG_GPIO_PALMAS=y
>  CONFIG_W1=m
> 
