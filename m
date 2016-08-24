From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 24 Aug 2016 10:26:40 -0500
Subject: [PATCH 06/10] reset: socfpga: add driver Kconfig option
In-Reply-To: <1472045342-7434-6-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-6-git-send-email-p.zabel@pengutronix.de>
Message-ID: <57BDBCB0.30607@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

just a minor nit:

On 08/24/2016 08:28 AM, Philipp Zabel wrote:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
> 
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig  | 6 ++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 6ac631e..354e281 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -49,6 +49,12 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
> +config RESET_SOCFPGA
> +	bool "SoC FPGA Reset Driver" if COMPILE_TEST

Prefer to be "SoCFPGA", no space in between.

> +	default ARCH_SOCFPGA
> +	help
> +	  This enables the reset driver for Altera SoC FPGAs.

Same here...

> +
>  config TI_SYSCON_RESET
>  	tristate "TI SYSCON Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index c796a14..61e4c64 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,5 +1,4 @@
>  obj-y += core.o
> -obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
> @@ -11,5 +10,6 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
> +obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> 

Otherwise,

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thanks,
Dinh
