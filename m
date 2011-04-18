From: Oskar.Andero@sonyericsson.com (=?iso-8859-1?Q?=22Ander=F6=2C_Oskar=22?=)
Date: Mon, 18 Apr 2011 17:51:29 +0200
Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
In-Reply-To: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ some extra CC's)

> Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
> 
> This fixes broken build when using gcc 4.5.
> 
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> index a45cd64..512b152 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -68,7 +68,7 @@ obj-$(CONFIG_OMAP_SMARTREFLEX)          +=
> sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> 
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
> -AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> +AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-
> a$(plus_sec)
> 
>  ifeq ($(CONFIG_PM_VERBOSE),y)
>  CFLAGS_pm_bus.o				+= -DDEBUG
> --
> 1.7.3.4
Ping!

Anyone else that gets bitten by the following when compiling omap2plus_defconfig with gcc 4.5:
arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does not support ARM mode `smc #1'

-Oskar
