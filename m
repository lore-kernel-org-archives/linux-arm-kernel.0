From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Aug 2015 13:19:22 +0200
Subject: [PATCH v3 1/5] input: touchscreen: add imx6ul_tsc driver support
In-Reply-To: <1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
 <1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150828131922.79693714@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Freescale i.MX6UL contains a internal touchscreen controller,
> this patch add a driver to support this controller.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  drivers/input/touchscreen/Kconfig      |  12 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/imx6ul_tsc.c | 524 +++++++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 059edeb..50a42b8 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -479,6 +479,18 @@ config TOUCHSCREEN_MTOUCH
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mtouch.
>  
> +config TOUCHSCREEN_IMX6UL_TSC
> +	tristate "Freescale i.MX6UL touchscreen controller"
> +	depends on (OF && GPIOLIB) || COMPILE_TEST
> +	help
> +	  Say Y here if you have a Freescale i.MX6UL, and want to
> +	  use the internal touchscreen controller.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  moduel will be called imx6ul_tsc.
>
s/moduel/module/


Lothar Wa?mann
