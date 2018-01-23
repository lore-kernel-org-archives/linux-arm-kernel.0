From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 23 Jan 2018 20:52:53 +0800
Subject: [PATCH 1/1] clk: remove invalid __clk_set_parent comment in
 __clk_core_init
In-Reply-To: <1513936041-13010-1-git-send-email-aisheng.dong@nxp.com>
References: <1513936041-13010-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180123125253.GB16865@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 05:47:21PM +0800, Dong Aisheng wrote:
> Those comments are invalid anymore. So remove them.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Ping

Regards
Dong Aisheng

> ---
>  drivers/clk/clk.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d6e2d5c..4675adf 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2927,10 +2927,6 @@ static int __clk_core_init(struct clk_core *core)
>  		struct clk_core *parent = __clk_init_parent(orphan);
>  		unsigned long flags;
>  
> -		/*
> -		 * we could call __clk_set_parent, but that would result in a
> -		 * redundant call to the .set_rate op, if it exists
> -		 */
>  		if (parent) {
>  			/* update the clk tree topology */
>  			flags = clk_enable_lock();
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
