From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 5 Apr 2012 16:31:30 +0200
Subject: [PATCH] ARM: at91: Export at91_st_base
In-Reply-To: <1333559715-28649-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333559715-28649-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <20120405143130.GA16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:15 Wed 04 Apr     , Joachim Eastwood wrote:
> After commit 5e9cf5e18d4b "ARM: at91: make ST (System Timer) soc independent"
> building at91rm9200_wdt as a module fails with following message
>   ERROR: "at91_st_base" [drivers/watchdog/at91rm9200_wdt.ko] undefined!
>   make[1]: *** [__modpost] Error 1
>   make: *** [modules] Error 2
> 
> Export symbol to allow wdt driver to be built as a module again.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
>  arch/arm/mach-at91/at91rm9200_time.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index dd7f782..bb0e7fd 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -23,6 +23,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/clockchips.h>
> +#include <linux/export.h>
>  
>  #include <asm/mach/time.h>
>  
> @@ -176,6 +177,7 @@ static struct clock_event_device clkevt = {
>  };
>  
>  void __iomem *at91_st_base;
> +EXPORT_SYMBOL(at91_st_base);
EXPORT_SYMBOL_GPL

Best Regards,
J.
