From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 03 Jun 2014 10:37:44 -0700
Subject: [PATCH] clk: export __clk_round_rate for providers
In-Reply-To: <6099360.oW6xYL5CNm@wuerfel>
References: <6099360.oW6xYL5CNm@wuerfel>
Message-ID: <20140603173744.10062.55679@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2014-06-03 02:40:14)
> Commit 99cbd064b0 ("clk: qcom: Support display RCG clocks") adds
> a use of the __clk_round_rate in a clock provided that can be built
> as a loadable module.
> 
> This exports the symbol to avoid the build error from compiling
> the qcom clock as a module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Mike Turquette <mturquette@linaro.org>

Applied.

Thanks,
Mike

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2df2b26..8b73ede 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1006,6 +1006,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>         else
>                 return clk->rate;
>  }
> +EXPORT_SYMBOL_GPL(__clk_round_rate);
>  
>  /**
>   * clk_round_rate - round the given rate for a clk
> 
