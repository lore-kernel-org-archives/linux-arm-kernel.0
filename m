From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Feb 2013 11:29:58 -0800
Subject: [PATCH 3.9-rc1] clk: vt8500: Fix variable name '*prate' compile
 error
In-Reply-To: <1361900052-66917-1-git-send-email-tim.gardner@canonical.com>
References: <1361900052-66917-1-git-send-email-tim.gardner@canonical.com>
Message-ID: <20130226192958.14870.54664@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tim Gardner (2013-02-26 09:34:12)
> commit 72480014b86c8b51fb51c5c6a0525876055c37c7 (clk: vt8500: Fix device clock
> divisor calculations) introduced a compile error in the naming of a variable in
> vt8500_dclk_set_rate(). It looks like a simple cut and paste error.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Tim,

Thanks for the fix.  I already have a fix for this issue in my clk-fixes
branch.  In fact I forgot to bundle this one and another mxs fix in my
3.9 pull request so I'll send a follow-up bugfix branch after 3.9-rc1 is
out.

Regards,
Mike

> ---
>  drivers/clk/clk-vt8500.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
> index b5538bb..09c6331 100644
> --- a/drivers/clk/clk-vt8500.c
> +++ b/drivers/clk/clk-vt8500.c
> @@ -157,7 +157,7 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
>         divisor =  parent_rate / rate;
>  
>         /* If prate / rate would be decimal, incr the divisor */
> -       if (rate * divisor < *prate)
> +       if (rate * divisor < parent_rate)
>                 divisor++;
>  
>         if (divisor == cdev->div_mask + 1)
> -- 
> 1.7.9.5
