From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 May 2013 10:15:11 -0700
Subject: [PATCH v3 4/6] clk: samsung: Add set_rate() clk_ops for PLL36xx
In-Reply-To: <1370003496-19288-5-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-5-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=XP3s+uJL+31XFz6r=BW5mGXDiK8EMT04rRwNf-XFa8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas and Yadwinder,

On Fri, May 31, 2013 at 5:31 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
>  struct clk * __init samsung_clk_register_pll36xx(const char *name,
> @@ -264,6 +318,11 @@ struct clk * __init samsung_clk_register_pll36xx(const char *name,
>         init.parent_names = &pname;
>         init.num_parents = 1;
>
> +       if (rate_table && rate_count)
> +               init.ops = &samsung_pll36xx_clk_ops;
> +       else
> +               init.ops = &samsung_pll36xx_clk_min_ops;
> +
>         pll->hw.init = &init;
>         pll->base = base;
>         pll->rate_table = rate_table;

Interesting.  In the gerrit review you sent for v2 you properly
removed the line:

  init.ops = &samsung_pll36xx_clk_ops;

...but the v2 you posted upstream didn't have that removal.  You've
also lost it in v3.  Perhaps you can add that back in?  I'll do it
locally before applying.


-Doug
