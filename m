From: egtvedt@samfundet.no (Hans-Christian Noren Egtvedt)
Date: Fri, 19 Jan 2018 11:50:58 +0100
Subject: [PATCH] input: touchscreen: remove atmel-wm97xx
In-Reply-To: <20180119081745.17557-1-clabbe.montjoie@gmail.com>
References: <20180119081745.17557-1-clabbe.montjoie@gmail.com>
Message-ID: <20180119105058.bjh2gatrmga5yrni@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Fri 19 Jan 2018 09:17:45 +0100 or thereabout, Corentin Labbe wrote:
> Since AVR32 arch is gone, atmel-wm97xx driver is useless.
> Remove it.

In theory it could have been rewritten to work with AT91 devices, but I would
recommend starting from scratch. This driver is from the platform data era,
and IIRC a bit hard coded to work on AVR32 hardware variant of the AC97C
peripheral.

> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/input/touchscreen/Kconfig        |  15 --
>  drivers/input/touchscreen/Makefile       |   1 -
>  drivers/input/touchscreen/atmel-wm97xx.c | 436 -------------------------------
>  3 files changed, 452 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/atmel-wm97xx.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 38a226f9fcbd..4f15496fec8b 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -795,21 +795,6 @@ config TOUCHSCREEN_WM9713
>  	  Say Y here to enable support for the Wolfson Microelectronics
>  	  WM9713 touchscreen controller.
>  
> -config TOUCHSCREEN_WM97XX_ATMEL
> -	tristate "WM97xx Atmel accelerated touch"
> -	depends on TOUCHSCREEN_WM97XX && AVR32
> -	help
> -	  Say Y here for support for streaming mode with WM97xx touchscreens
> -	  on Atmel AT91 or AVR32 systems with an AC97C module.
> -
> -	  Be aware that this will use channel B in the controller for
> -	  streaming data, this must not conflict with other AC97C drivers.
> -
> -	  If unsure, say N.
> -
> -	  To compile this driver as a module, choose M here: the module will
> -	  be called atmel-wm97xx.
> -
>  config TOUCHSCREEN_WM97XX_MAINSTONE
>  	tristate "WM97xx Mainstone/Palm accelerated touch"
>  	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index d2a2b3b7af27..dddae7973436 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -97,7 +97,6 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
>  wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
>  wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
>  wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713)	+= wm9713.o
> -obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)	+= atmel-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o

<snipp diff>

-- 
mvh
Hans-Christian Noren Egtvedt
