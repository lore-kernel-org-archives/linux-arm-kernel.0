From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jul 2014 04:07:31 -0700
Subject: [PATCH 3/8] ARM: OMAP2+: timer: Add comment on timer clk parenting
In-Reply-To: <1398216429-4681-4-git-send-email-joelf@ti.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
 <1398216429-4681-4-git-send-email-joelf@ti.com>
Message-ID: <20140721110730.GX18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [140422 18:27]:
> Add a comment describing the state of system timer clock parenting.  The code
> following the comment should be deleted once all platforms can do DT boot, and
> specially should not be executed for DT platforms once we can specify default
> clock parents through DT.

I think we can do it already for DT based booting?

Regards,

Tony
 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index f192a41..9fdff5b 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -313,6 +313,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(timer->fclk))
>  		return PTR_ERR(timer->fclk);
>  
> +	/*
> +	 * Clock reparenting code, goes away for DT-boot atleast,
> +	 * once clock layer can do it through DT.
> +	 */
>  	src = clk_get(NULL, fck_source);
>  	if (IS_ERR(src))
>  		return PTR_ERR(src);
> -- 
> 1.7.9.5
> 
