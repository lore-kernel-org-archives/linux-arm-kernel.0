From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 05 Oct 2014 13:43:58 -0700
Subject: [PATCH v1] clk: pxa clocks build system fix
In-Reply-To: <1412199569-27958-1-git-send-email-robert.jarzmik@free.fr>
References: <1412199569-27958-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20141005204358.4379.67145@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-10-01 14:39:29)
> Fix the building of pxa clock drivers so that the files are actually
> compiled if and only if COMMON_CLK was selected by the architecture.
> 
> This prevents conflicts with mach-pxa clock legacy implementation.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied.

Thanks,
Mike

> ---
>  drivers/clk/Kconfig  | 5 +++++
>  drivers/clk/Makefile | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index cfd3af7..b110f33 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -109,6 +109,11 @@ config COMMON_CLK_PALMAS
>           This driver supports TI Palmas devices 32KHz output KG and KG_AUDIO
>           using common clock framework.
>  
> +config COMMON_CLK_PXA
> +       def_bool COMMON_CLK && ARCH_PXA
> +       ---help---
> +         Sypport for the Marvell PXA SoC.
> +
>  source "drivers/clk/qcom/Kconfig"
>  
>  endmenu
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 7891e4e..b3a1da0 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -48,7 +48,7 @@ obj-$(CONFIG_ARCH_MMP)                        += mmp/
>  endif
>  obj-$(CONFIG_PLAT_ORION)               += mvebu/
>  obj-$(CONFIG_ARCH_MXS)                 += mxs/
> -obj-$(CONFIG_ARCH_PXA)                 += pxa/
> +obj-$(CONFIG_COMMON_CLK_PXA)           += pxa/
>  obj-$(CONFIG_COMMON_CLK_QCOM)          += qcom/
>  obj-$(CONFIG_ARCH_ROCKCHIP)            += rockchip/
>  obj-$(CONFIG_COMMON_CLK_SAMSUNG)       += samsung/
> -- 
> 2.1.0
> 
