From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Sep 2013 09:20:24 +0200
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <52428EB8.9010607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2013 19:41, Uwe Kleine-K?nig :
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
>
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>   arch/arm/Kconfig               | 12 ------------
>   arch/arm/mach-highbank/Kconfig |  1 -
>   arch/arm/mach-imx/Kconfig      | 10 +---------
>   arch/arm/mach-omap2/Kconfig    |  9 +--------
>   arch/arm/mach-socfpga/Kconfig  |  1 -
>   arch/arm/mach-spear/Kconfig    |  2 --
>   arch/arm/mach-tegra/Kconfig    |  2 --
>   arch/arm/mach-u300/Kconfig     |  1 -
>   arch/arm/mach-ux500/Kconfig    | 29 ++++++++++++-----------------
>   arch/arm/mach-vexpress/Kconfig |  2 --
>   arch/arm/mach-vt8500/Kconfig   |  1 -
>   11 files changed, 14 insertions(+), 56 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3230f4c..66164a0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -360,7 +360,6 @@ config ARCH_AT91
>   	bool "Atmel AT91"
>   	select ARCH_REQUIRE_GPIOLIB
>   	select CLKDEV_LOOKUP
> -	select HAVE_CLK

For AT91:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


>   	select IRQ_DOMAIN
>   	select NEED_MACH_GPIO_H
>   	select NEED_MACH_IO_H if PCCARD

[..]

Thanks Uwe, bye,
-- 
Nicolas Ferre
