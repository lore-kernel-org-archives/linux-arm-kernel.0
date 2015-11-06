From: a0131933@ti.com (Lokesh Vutla)
Date: Fri, 6 Nov 2015 13:35:16 +0530
Subject: [PATCH] arm: omap2: board-generic: use omap4_local_timer_init for
 AM437x
In-Reply-To: <1445375159-22234-1-git-send-email-balbi@ti.com>
References: <1445375159-22234-1-git-send-email-balbi@ti.com>
Message-ID: <563C5F3C.5090900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 21 October 2015 02:35 AM, Felipe Balbi wrote:
> AM437x-based boards, can use omap4_local_timer_init()
> just fine. Let's use that instead.

This is breaking AM43x-epos board.
Today's Linux next: http://pastebin.ubuntu.com/13122620/
Reverting this patch: http://pastebin.ubuntu.com/13122621/

Thanks and regards,
Lokesh

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index fc107bdeb8ca..04a56cc04dfa 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -276,7 +276,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
>  	.init_late	= am43xx_init_late,
>  	.init_irq	= omap_gic_of_init,
>  	.init_machine	= omap_generic_init,
> -	.init_time	= omap3_gptimer_timer_init,
> +	.init_time	= omap4_local_timer_init,
>  	.dt_compat	= am43_boards_compat,
>  	.restart	= omap44xx_restart,
>  MACHINE_END
> 
