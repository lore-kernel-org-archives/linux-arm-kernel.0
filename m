From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Sep 2018 13:42:12 -0300
Subject: [PATCH v9 4/5] clk: imx: add imx composite clock
In-Reply-To: <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAOMZO5D7yLUzriOub4RWsq1K8_fTj6c0LFOnSZwHyjqMPYu=0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Mon, Sep 24, 2018 at 7:39 AM, Abel Vesa <abel.vesa@nxp.com> wrote:

> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       int prediv_value;
> +       int div_value;
> +
> +       imx_clk_composite_compute_dividers(rate, *prate,
> +                                               &prediv_value, &div_value);
> +
> +       rate = DIV_ROUND_UP_ULL((u64)*prate, prediv_value);

You assing a value to 'rate' here.

> +       rate = DIV_ROUND_UP_ULL((u64)rate, div_value);

And then overwrite it immediately after.

Is this really the intended behavior?
