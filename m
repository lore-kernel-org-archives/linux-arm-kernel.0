From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 27 Aug 2015 16:02:31 -0700
Subject: [PATCH 1/2] clk: atlas7: move variable-definition together
In-Reply-To: <1439514663-23979-1-git-send-email-21cnbao@gmail.com>
References: <1439514663-23979-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150827230231.30921.20071@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Barry Song (2015-08-13 18:11:02)
> From: Guo Zeng <Guo.Zeng@csr.com>
> 
> re-order the codes more reasonable by moving variable-definition
> together.
> 
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Hi Barry,

I'll apply these after -rc1 drops, towards 4.4. Please be sure to Cc
linux-clk at vger.kernel.org for future clk patches.

Thanks!
Mike

> ---
>  drivers/clk/sirf/clk-atlas7.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
> index a98e21f..d34d1b3 100644
> --- a/drivers/clk/sirf/clk-atlas7.c
> +++ b/drivers/clk/sirf/clk-atlas7.c
> @@ -206,18 +206,6 @@
>  #define SIRFSOC_CLKC_LEAF_CLK_EN8_SET        0x0548
>  
>  
> -static void __iomem *sirfsoc_clk_vbase;
> -static struct clk_onecell_data clk_data;
> -
> -static const struct clk_div_table pll_div_table[] = {
> -       { .val = 0, .div = 1 },
> -       { .val = 1, .div = 2 },
> -       { .val = 2, .div = 4 },
> -       { .val = 3, .div = 8 },
> -       { .val = 4, .div = 16 },
> -       { .val = 5, .div = 32 },
> -};
> -
>  struct clk_pll {
>         struct clk_hw hw;
>         u16 regofs;  /* register offset */
> @@ -284,6 +272,18 @@ struct atlas7_reset_desc {
>         spinlock_t *lock;
>  };
>  
> +static void __iomem *sirfsoc_clk_vbase;
> +static struct clk_onecell_data clk_data;
> +
> +static const struct clk_div_table pll_div_table[] = {
> +       { .val = 0, .div = 1 },
> +       { .val = 1, .div = 2 },
> +       { .val = 2, .div = 4 },
> +       { .val = 3, .div = 8 },
> +       { .val = 4, .div = 16 },
> +       { .val = 5, .div = 32 },
> +};
> +
>  static DEFINE_SPINLOCK(cpupll_ctrl1_lock);
>  static DEFINE_SPINLOCK(mempll_ctrl1_lock);
>  static DEFINE_SPINLOCK(sys0pll_ctrl1_lock);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
