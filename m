From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Jan 2016 14:18:34 +0800
Subject: [PATCH v3 1/2] clk: sunxi: factors: Add missing recalc pointer
 copy
In-Reply-To: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66dbtBPwRQzA3rtP5hu-0rvfaX2ac7KWRiF42wtEiafwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 3:22 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Commit 4a9b2abc213e ("clk: sunxi: factors: Support custom formulas") was
> introducing a custom recalc function. However, the pointer was never
> filled, which was making the whole thing unused.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

(facepalm)

Acked-by: Chen-Yu Tsai <wens@csie.org>

Can you squash it into the original?
Thanks


> ---
>  drivers/clk/sunxi/clk-factors.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index e480a6bcf1f6..6e97f46c0c37 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -212,6 +212,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
>         factors->reg = reg;
>         factors->config = data->table;
>         factors->get_factors = data->getter;
> +       factors->recalc = data->recalc;
>         factors->lock = lock;
>
>         /* Add a gate if this factor clock can be gated */
> --
> 2.6.4
>
