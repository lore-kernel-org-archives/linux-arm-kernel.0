From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 23 Apr 2010 09:17:41 +0300
Subject: [PATCH] arm/plat-mxc: Fix forgotten renaming in timer.c
In-Reply-To: <1271998183-14294-1-git-send-email-w.sang@pengutronix.de>
References: <1271998183-14294-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100423061741.GA2112@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Apr 23, Wolfram Sang wrote:
> Commit "mxc: Change gpt timer code to be more generic by using V2
> instead of MX3" forgot to replace one occurence causing a build
> failure.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Amit Kucheria <amit.kucheria@canonical.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Oops-Acked-by: Amit Kucheria <amit.kucheria@canonical.com>

Thanks for the catch. :)

> ---
>  arch/arm/plat-mxc/time.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> index 714bdef..f9a1b05 100644
> --- a/arch/arm/plat-mxc/time.c
> +++ b/arch/arm/plat-mxc/time.c
> @@ -102,7 +102,7 @@ static void gpt_irq_acknowledge(void)
>  			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
>  				timer_base + MX1_2_TSTAT);
>  	} else if (timer_is_v2())
> -		__raw_writel(MX3_TSTAT_OF1, timer_base + MX3_TSTAT);
> +		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
>  }
>  
>  static cycle_t mx1_2_get_cycles(struct clocksource *cs)
> -- 
> 1.7.0
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
