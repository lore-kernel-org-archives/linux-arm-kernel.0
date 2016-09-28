From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Sep 2016 21:21:30 +0200
Subject: [PATCH v2 02/10] reset: berlin: add driver Kconfig option
In-Reply-To: <1472545496-14373-2-git-send-email-p.zabel@pengutronix.de>
References: <1472545496-14373-1-git-send-email-p.zabel@pengutronix.de>
 <1472545496-14373-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <57EC183A.6080406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.08.2016 10:24, Philipp Zabel wrote:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Sorry for the late reply, FWIW

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


> ---
>   drivers/reset/Kconfig  | 6 ++++++
>   drivers/reset/Makefile | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 9da0507..1194cbe 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -21,6 +21,12 @@ config RESET_ATH79
>   	  This enables the ATH79 reset controller driver that supports the
>   	  AR71xx SoC reset controller.
>
> +config RESET_BERLIN
> +	bool "Berlin Reset Driver" if COMPILE_TEST
> +	default ARCH_BERLIN
> +	help
> +	  This enables the reset controller driver for Marvell Berlin SoCs.
> +
>   config RESET_OXNAS
>   	bool
>
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index e3fc337..34c0b23 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,7 +1,6 @@
>   obj-y += core.o
>   obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
>   obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
> -obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>   obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
>   obj-$(CONFIG_ARCH_MESON) += reset-meson.o
>   obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
> @@ -10,6 +9,7 @@ obj-$(CONFIG_ARCH_STI) += sti/
>   obj-$(CONFIG_ARCH_HISI) += hisilicon/
>   obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>   obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
> +obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>   obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>   obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>   obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>
