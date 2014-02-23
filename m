From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 23 Feb 2014 15:44:16 -0800
Subject: [PATCH 1/2] clk: tegra: Staticize tegra_clk_periph_no_gate_ops
In-Reply-To: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
References: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140223234416.22529.10370@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2014-01-14 21:43:25)
> tegra_clk_periph_no_gate_ops is a local symbol.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Pulled into clk-next.

Thanks!
Mike

> ---
>  drivers/clk/tegra/clk-periph.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
> index 356e9b804421..9e899c18af86 100644
> --- a/drivers/clk/tegra/clk-periph.c
> +++ b/drivers/clk/tegra/clk-periph.c
> @@ -130,7 +130,7 @@ static const struct clk_ops tegra_clk_periph_nodiv_ops = {
>         .disable = clk_periph_disable,
>  };
>  
> -const struct clk_ops tegra_clk_periph_no_gate_ops = {
> +static const struct clk_ops tegra_clk_periph_no_gate_ops = {
>         .get_parent = clk_periph_get_parent,
>         .set_parent = clk_periph_set_parent,
>         .recalc_rate = clk_periph_recalc_rate,
> -- 
> 1.7.9.5
> 
