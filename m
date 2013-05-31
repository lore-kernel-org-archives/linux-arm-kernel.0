From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 May 2013 10:10:58 -0700
Subject: [PATCH v3 3/6] clk: samsung: Add set_rate() clk_ops for PLL35xx
In-Reply-To: <1370003496-19288-4-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-4-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=UuEYCjaiTHn0B2iBUyKqA+KcbGWMu4iTNhSDFPz3311w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas and Yadwinder,

On Fri, May 31, 2013 at 5:31 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> +static long samsung_pll_round_rate(struct clk_hw *hw,
> +                       unsigned long drate, unsigned long *prate)
> +{
> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
> +       const struct samsung_pll_rate_table *rate_table = pll->rate_table;
> +       int i;
> +
> +       /* Assumming rate_table is in descending order */
> +       for (i = 0; i < pll->rate_count; i++) {
> +               if (drate >= rate_table[i].rate)
> +                       return rate_table[i].rate;
> +       }
> +
> +       /* return minimum supported value */
> +       return rate_table[i - 1].rate;
> +}
>  /*
>   * PLL35xx Clock Type
>   */

You seem to have lost a carriage return between v2 and v3.  I will add
it locally before applying.  This still looks good though and already
has my Reviewed-by.

-Doug
