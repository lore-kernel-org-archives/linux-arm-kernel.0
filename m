From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Nov 2013 13:48:43 -0800
Subject: [PATCH v5 06/17] clk: at91: add PMC pll clocks
In-Reply-To: <1384293439-4525-1-git-send-email-b.brezillon@overkiz.com>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
 <1384293439-4525-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131127214843.16819.59481@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2013-11-12 13:57:19)
> +static const struct clk_ops pll_ops = {
> +       .prepare = clk_pll_prepare,
> +       .is_prepared = clk_pll_is_ready,
> +       .disable = clk_pll_disable,
> +       .is_enabled = clk_pll_is_ready,
> +       .recalc_rate = clk_pll_recalc_rate,
> +       .round_rate = clk_pll_round_rate,
> +       .set_rate = clk_pll_set_rate,
> +};

Hi Boris,

It is a bit strange to see only a .prepare and .disable callback
populated. What happens if a driver calls clk_disable and then
clk_enable? You clock will still be disabled in hardware.

Regards,
Mike
