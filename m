From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Nov 2013 14:41:17 +0100
Subject: [PATCH] rtc: at91sam9: include <mach/hardware.h> explicitly
In-Reply-To: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131126134117.GF28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:00:58PM +0100, Uwe Kleine-K?nig wrote:
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
Ping. Is this patch ok despite Jean-Christophe's objection?

Best regards
Uwe

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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
