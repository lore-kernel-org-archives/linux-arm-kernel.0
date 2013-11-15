From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 15:23:27 +0100
Subject: [PATCH] rtc: at91sam9: include <mach/hardware.h> explicitly
In-Reply-To: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131115142327.GQ28304@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:00 Fri 15 Nov     , Uwe Kleine-K??nig wrote:
> The driver needs the symbol AT91_SLOW_CLOCK which is defined in
> arch/arm/mach-at91/include/mach/hardware.h. This file is included
> implicitly via linux/module.h -> linux/kmod.h -> linux/gfp.h ->
> linux/mmzone.h -> linux/memory_hotplug.h -> linux/notifier.h ->
> linux/srcu.h -> linux/workqueue.h -> linux/timer.h -> linux/ktime.h ->
> linux/jiffies.h -> linux/timex.h -> mach/timex.h -> mach/hardware.h .
> 
> So better include it explicitly not only because the last link will go
> away soon.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

we should never use this symbol you need to request the clock clk32k

Best Regards,
J.
> ---
>  drivers/rtc/rtc-at91sam9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 309b8b3..5963743 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -24,7 +24,7 @@
>  
>  #include <mach/at91_rtt.h>
>  #include <mach/cpu.h>
> -
> +#include <mach/hardware.h>
>  
>  /*
>   * This driver uses two configurable hardware resources that live in the
> -- 
> 1.8.4.2
> 
