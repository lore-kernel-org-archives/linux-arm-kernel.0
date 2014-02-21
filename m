From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Feb 2014 16:55:51 +0100
Subject: [PATCH] phy: restrict Samsung S5P/Exynos drivers to the respective
 architectures
In-Reply-To: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <53077707.9060409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/02/14 15:05, Uwe Kleine-K?nig wrote:
> Enabling these drivers on platforms not created by Samsung is useless
> unless you're doing compile tests. So don't offer the users to enable
> them without COMPILE_TEST for configs with S5P/Exynos disabled.

Thanks for the patch, I've already sent something similar to Kishon, but
I've messed up the mailing list address. A bit improved v2 I just posted
can be found here:

https://patchwork.kernel.org/patch/3698271/
https://patchwork.kernel.org/patch/3698251/

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/phy/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index c7a551c2d5f1..82a98f1a5ec2 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -18,6 +18,7 @@ config GENERIC_PHY
>  config PHY_EXYNOS_MIPI_VIDEO
>  	depends on HAS_IOMEM
>  	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
> +	depends on PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST
>  	help
>  	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
>  	  and EXYNOS SoCs.
> @@ -54,6 +55,7 @@ config TWL4030_USB
>  config PHY_EXYNOS_DP_VIDEO
>  	tristate "EXYNOS SoC series Display Port PHY driver"
>  	depends on OF
> +	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
>  	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
> 

Regards,
Sylwester
