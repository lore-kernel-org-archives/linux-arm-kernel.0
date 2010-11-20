From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 20 Nov 2010 22:42:38 +0100
Subject: [PATCH 5/6] at91: rename rm9200ek and rm9200dk board file name
In-Reply-To: <1290247733-17834-5-git-send-email-plagnioj@jcrosoft.com>
References: <20101120095906.GD4216@game.jcrosoft.org>
	<1290247733-17834-5-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20101120214238.GE8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Christophe,

On Sat, Nov 20, 2010 at 11:08:52AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> to be a few more concistant with the other boards
s/concistant/consistent/

> 
> as ek is for evaluation kit and dk for development kit
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/Makefile                        |    4 ++--
>  .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    0
>  .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (100%)
>  rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (100%)
arch/arm/mach-at91/board-dk.c starts with:

	/*
	 * linux/arch/arm/mach-at91/board-dk.c
	 *

IMHO you should adapt (or delete) this line.

> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 821eb84..62d686f 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -24,8 +24,8 @@ obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
>  
>  # AT91RM9200 board-specific support
>  obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
> -obj-$(CONFIG_ARCH_AT91RM9200DK)	+= board-dk.o
> -obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-ek.o
> +obj-$(CONFIG_ARCH_AT91RM9200DK)	+= board-rm9200dk.o
> +obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
>  obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
>  obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
>  obj-$(CONFIG_MACH_CARMEVA)	+= board-carmeva.o
> diff --git a/arch/arm/mach-at91/board-dk.c b/arch/arm/mach-at91/board-rm9200dk.c
> similarity index 100%
> rename from arch/arm/mach-at91/board-dk.c
> rename to arch/arm/mach-at91/board-rm9200dk.c
> diff --git a/arch/arm/mach-at91/board-ek.c b/arch/arm/mach-at91/board-rm9200ek.c
> similarity index 100%
> rename from arch/arm/mach-at91/board-ek.c
> rename to arch/arm/mach-at91/board-rm9200ek.c
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
