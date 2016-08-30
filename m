From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 30 Aug 2016 12:01:32 +0200
Subject: [PATCH v2 09/10] reset: zynq: add driver Kconfig option
In-Reply-To: <1472545496-14373-9-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
 <1472545496-14373-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <3b05186e-96cf-6d17-c654-277db26f5a94@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.8.2016 10:24, Philipp Zabel wrote:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
> 
> Cc: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v1:
>  - Fix alphabetical order of Kconfig options
> ---
>  drivers/reset/Kconfig  | 6 ++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7f748af..06d9fa2 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -86,6 +86,12 @@ config RESET_UNIPHIER
>  	  Say Y if you want to control reset signals provided by System Control
>  	  block, Media I/O block, Peripheral Block.
>  
> +config RESET_ZYNQ
> +	bool "ZYNQ Reset Driver" if COMPILE_TEST
> +	default ARCH_ZYNQ
> +	help
> +	  This enables the reset controller driver for Xilinx Zynq SoCs.
> +
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4a163c7..56f90ea 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,7 +1,6 @@
>  obj-y += core.o
>  obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_ARCH_HISI) += hisilicon/
> -obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> @@ -13,3 +12,4 @@ obj-$(CONFIG_RESET_STM32) += reset-stm32.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> +obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
