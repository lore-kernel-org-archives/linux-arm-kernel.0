From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Mar 2014 12:28:28 +0100
Subject: [PATCH] clk: turn rate change failed warning into pr_debug
In-Reply-To: <1389885175-14174-1-git-send-email-s.hauer@pengutronix.de>
References: <1389885175-14174-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140305112828.GN24917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Any objections to this patch?

Sascha

On Thu, Jan 16, 2014 at 04:12:55PM +0100, Sascha Hauer wrote:
> If a rate change failed it's the opportunity of the caller to handle
> this. Do not spam the log with a message.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2cf2ea6..f0124d4 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1460,7 +1460,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>  	/* notify that we are about to change rates */
>  	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>  	if (fail_clk) {
> -		pr_warn("%s: failed to set %s rate\n", __func__,
> +		pr_debug("%s: failed to set %s rate\n", __func__,
>  				fail_clk->name);
>  		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
>  		ret = -EBUSY;
> -- 
> 1.8.5.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
