From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 24 Aug 2016 22:32:00 +0200
Subject: [PATCH 03/10] reset: lpc18xx: add driver Kconfig option
In-Reply-To: <1472045342-7434-3-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAGhQ9VzvU+1qzmmy9NeZmJxX7AS1ez6b4qJuq99J_drSpjJOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 24 August 2016 at 15:28, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig  | 7 +++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 1194cbe..8e33de2 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -27,6 +27,13 @@ config RESET_BERLIN
>         help
>           This enables the reset controller driver for Marvell Berlin SoCs.
>
> +config RESET_LPC18XX
> +       bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
> +       default ARCH_LPC18XX
> +       help
> +         This enables the LPC18xx/43 reset driver that supports the reset
> +         controllers on AR71xx SoCs.

Don't know where you got the "AR71xx SoCs" from. This reset controller
is found on NXP LPC18xx/43xx SoCs.

Other than that it looks fine to me.

Acked-by: Joachim Eastwood <manabian@gmail.com>


> +
>  config RESET_OXNAS
>         bool
>
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 34c0b23..25aa05a 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,5 +1,4 @@
>  obj-y += core.o
> -obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
>  obj-$(CONFIG_ARCH_MESON) += reset-meson.o
> @@ -10,6 +9,7 @@ obj-$(CONFIG_ARCH_HISI) += hisilicon/
>  obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> --
> 2.8.1


regards,
Joachim Eastwood
