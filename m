From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 15:01:56 -0700
Subject: [PATCH] ARM: OMAP: fix return value check in
 realtime_counter_init()
In-Reply-To: <CAPgLHd_X+vT-AtkHCAmmieEtdQbVz6RcUWogY83qZyvzK_tidA@mail.gmail.com>
References: <CAPgLHd_X+vT-AtkHCAmmieEtdQbVz6RcUWogY83qZyvzK_tidA@mail.gmail.com>
Message-ID: <20121008220156.GX13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [121007 07:00]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().

Thanks applying into omap fixes.

Tony
 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 8847d6e..44f9aa7 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -378,7 +378,7 @@ static void __init realtime_counter_init(void)
>  		return;
>  	}
>  	sys_clk = clk_get(NULL, "sys_clkin_ck");
> -	if (!sys_clk) {
> +	if (IS_ERR(sys_clk)) {
>  		pr_err("%s: failed to get system clock handle\n", __func__);
>  		iounmap(base);
>  		return;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
