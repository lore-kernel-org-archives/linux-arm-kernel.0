From: mturquette@linaro.org (Michael Turquette)
Date: Tue, 12 May 2015 15:32:41 -0700
Subject: [PATCH v2 3/4] clk: add lpc18xx ccu clk driver
In-Reply-To: <1430170693-28303-4-git-send-email-manabian@gmail.com>
References: <1430170693-28303-1-git-send-email-manabian@gmail.com>
 <1430170693-28303-4-git-send-email-manabian@gmail.com>
Message-ID: <20150512223241.16410.79958@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joachim Eastwood (2015-04-27 14:38:12)
> +static int of_clk_get_parent_arg(struct device_node *np, int index)
> +{
> +       struct of_phandle_args clkspec;
> +       int rc;
> +
> +       if (index < 0)
> +               return -EINVAL;
> +
> +       rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
> +                                       &clkspec);
> +       if (rc)
> +               return -EINVAL;
> +
> +       return clkspec.args_count ? clkspec.args[0] : -EINVAL;
> +}

Hi Joachim,

I'm not sure why you need this. I guess it is related to my question in
patch #2 about using clock-indices? Can you explain why this function is
required?

Anyways if returning the clock index is something that is really needed
then why not rename it to "of_clk_get_index" and put it in
drivers/clk/clk.c?

Thanks,
Mike
