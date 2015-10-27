From: alison.wang@freescale.com (Huan Wang)
Date: Tue, 27 Oct 2015 02:58:06 +0000
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
In-Reply-To: <1437124312-44700-1-git-send-email-b18965@freescale.com>
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
Message-ID: <BN3PR0301MB08673CC5ED6420345E221974FE220@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

	Could you comment this patch? It is based on your suggestion in https://patchwork.kernel.org/patch/6764231/ .

	Thanks.

Best Regards,
Alison Wang

> -----Original Message-----
> From: Alison Wang [mailto:b18965 at freescale.com]
> Sent: Friday, July 17, 2015 5:12 PM
> To: mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Cc: Wang Huan-B18965
> Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
> 
> Hrtimer based broadcast is used on ARM platform. It can be registered as
> the tick broadcast device in the absence of a real external clock device.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> ---
>  arch/arm/kernel/time.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c index
> a66e37e..a9bc73c 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -12,6 +12,7 @@
>   *  reading the RTC at bootup, etc...
>   */
>  #include <linux/clk-provider.h>
> +#include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> @@ -121,5 +122,7 @@ void __init time_init(void)
>  		of_clk_init(NULL);
>  #endif
>  		clocksource_of_init();
> +
> +		tick_setup_hrtimer_broadcast();
>  	}
>  }
> --
> 2.1.0.27.g96db324
