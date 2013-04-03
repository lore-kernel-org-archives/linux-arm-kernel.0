From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Apr 2013 14:48:46 -0700
Subject: [PATCH v2 6/7] clk: sunxi: drop CLK_IGNORE_UNUSED
In-Reply-To: <1364419243-18446-7-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-7-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130403214846.3383.2417@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-03-27 14:20:42)
> This flag was in place to prevent important clocks from getting gated
> while they had no users. Now that the UART driver supports clocks
> properly, we can drop this.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

This change looks good to me.

Regards,
Mike

> ---
> 
> Changes from v1:
>   - no changes
> 
>  drivers/clk/sunxi/clk-sunxi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 244de90..daa51ab 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -41,8 +41,8 @@ static void __init sunxi_osc_clk_setup(struct device_node *node)
>  
>         parent = of_clk_get_parent_name(node, 0);
>  
> -       clk = clk_register_gate(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
> -                               reg, SUNXI_OSC24M_GATE, 0, &clk_lock);
> +       clk = clk_register_gate(NULL, clk_name, parent, 0, reg,
> +                               SUNXI_OSC24M_GATE, 0, &clk_lock);
>  
>         if (clk) {
>                 of_clk_add_provider(node, of_clk_src_simple_get, clk);
> @@ -198,8 +198,8 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  
>         parent = of_clk_get_parent_name(node, 0);
>  
> -       clk = clk_register_factors(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
> -                                  reg, data->table, data->getter, &clk_lock);
> +       clk = clk_register_factors(NULL, clk_name, parent, 0, reg,
> +                                  data->table, data->getter, &clk_lock);
>  
>         if (clk) {
>                 of_clk_add_provider(node, of_clk_src_simple_get, clk);
> -- 
> 1.8.2
