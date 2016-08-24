From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 25 Aug 2016 02:48:07 +0900
Subject: [PATCH 09/10] reset: zynq: add driver Kconfig option
In-Reply-To: <1472045342-7434-9-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAK7LNATr0WDx0aMXEJMxrDY6WxBtqis-DkZiOjGnrjM8zqYi-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-24 22:29 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Visible only if COMPILE_TEST is enabled, this allows to include the
> driver in build tests.
>
> Cc: Moritz Fischer <moritz.fischer@ettus.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig  | 6 ++++++
>  drivers/reset/Makefile | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 17030e2..86b49a2 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -67,6 +67,12 @@ config RESET_SUNXI
>         help
>           This enables the reset driver for Allwinner SoCs.
>
> +config RESET_ZYNQ
> +       bool "ZYNQ Reset Driver" if COMPILE_TEST
> +       default ARCH_ZYNQ
> +       help
> +         This enables the reset driver for Xilinx Zynq FPGAs.
> +

Please move this below RESET_UNIPHIER
as I assume you are sorting Kconfig entries alphabetically.


Otherwise,

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
