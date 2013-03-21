From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 21 Mar 2013 13:53:10 -0700
Subject: [PATCH V2 1/3] clk: Restructure code for __clk_reparent
In-Reply-To: <1363873693-30902-2-git-send-email-ulf.hansson@stericsson.com>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
 <1363873693-30902-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130321205310.834.2857@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2013-03-21 06:48:11)
> +void __clk_reparent(struct clk *clk, struct clk *new_parent)
> +{
> +       clk_reparent(clk, new_parent);
> +       clk_debug_reparent(clk, new_parent);
>         __clk_recalc_rates(clk, POST_RATE_CHANGE);
>  }
>  
> @@ -1364,7 +1378,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>         }
>  
>         /* propagate rate recalculation downstream */
> -       __clk_reparent(clk, parent);
> +       clk_reparent(clk, parent);
> +       clk_debug_reparent(clk, parent);
> +       __clk_recalc_rates(clk, POST_RATE_CHANGE);
>  

This is an interesting change.  Why not call __clk_reparent here instead
of open coding an identical sequence?

Regards,
Mike
