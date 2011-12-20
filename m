From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 10:15:33 +0800
Subject: [PATCH V3 10/14] ARM: mxs: add clk_prepare/clk_unprepare
In-Reply-To: <1321008637-19999-11-git-send-email-richard.zhao@linaro.org>
References: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
 <1321008637-19999-11-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111220021532.GA2995@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Can you drop this patch from your tree?  This patch is not complete
even for mxs platform/arch code, and will conflict with my mxs
clk-prepare series.

-- 
Regards,
Shawn

On Fri, Nov 11, 2011 at 06:50:33PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/mach-mxs/system.c |    2 +-
>  arch/arm/mach-mxs/timer.c  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> index 20ec3bd..9760a12 100644
> --- a/arch/arm/mach-mxs/system.c
> +++ b/arch/arm/mach-mxs/system.c
> @@ -66,7 +66,7 @@ static int __init mxs_arch_reset_init(void)
>  
>  	clk = clk_get_sys("rtc", NULL);
>  	if (!IS_ERR(clk))
> -		clk_enable(clk);
> +		clk_prepare_enable(clk);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> index cace0d2..564a632 100644
> --- a/arch/arm/mach-mxs/timer.c
> +++ b/arch/arm/mach-mxs/timer.c
> @@ -245,7 +245,7 @@ static int __init mxs_clocksource_init(struct clk *timer_clk)
>  
>  void __init mxs_timer_init(struct clk *timer_clk, int irq)
>  {
> -	clk_enable(timer_clk);
> +	clk_prepare_enable(timer_clk);
>  
>  	/*
>  	 * Initialize timers to a known state
> -- 
> 1.7.5.4
