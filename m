From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Feb 2011 17:29:54 -0800
Subject: [PATCH][trivial] ARM, OMAP, timer: Remove duplicate inclusion
	of linux/sched.h from arch/arm/mach-omap1/time.c
In-Reply-To: <alpine.LNX.2.00.1102032255090.1369@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1102032255090.1369@swampdragon.chaosbits.net>
Message-ID: <20110204012953.GO3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jesper Juhl <jj@chaosbits.net> [110203 13:57]:
> arch/arm/mach-omap1/time.c includes linux/sched.h twice - it's enough to 
> do it once. This removes the duplicate.

Thanks, already have a similar fix queued in my devel-fixes branch.

Regards,

Tony
 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  time.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
> index f83fc33..6885d2f 100644
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -44,7 +44,6 @@
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/io.h>
> -#include <linux/sched.h>
>  
>  #include <asm/system.h>
>  #include <mach/hardware.h>
> 
> 
> -- 
> Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
> Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please.
> 
