From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 21:32:18 +0800
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120728133215.GG2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 02:37:43PM +0200, Dirk Behme wrote:
> From: Matthias Thomae <matthias.thomae@de.bosch.com>
> 
> Set ARCH_NR_GPIO for the i.MX6 processor family, which has 7 GPIO
> controllers with 32 signals each. The default of 256 GPIOs wastes
> some static table space as explained in Documentation/gpio.txt.
> 
> Signed-off-by: Matthias Thomae <matthias.thomae@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b25c9d3..5e4cde3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1626,6 +1626,7 @@ config ARCH_NR_GPIO
>  	default 355 if ARCH_U8500
>  	default 264 if MACH_H4700
>  	default 512 if SOC_OMAP5
> +	default 224 if SOC_IMX6Q

So what if we build imx_v6_v7_defconfig with IMX6Q deselected?

-- 
Regards,
Shawn

>  	default 0
>  	help
>  	  Maximum number of GPIOs in the system.
> -- 
> 1.7.0.4
> 
