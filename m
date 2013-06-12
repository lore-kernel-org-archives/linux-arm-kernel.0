From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 17:52:15 -0700
Subject: [PATCH] clk: tegra: fix sclk_parents
In-Reply-To: <1370442573-17512-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370442573-17512-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130612005215.8816.58802@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2013-06-05 07:29:28)
> Use the correct parents for sclk according to the TRM.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/tegra/clk-tegra114.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index 2774379e..758ba7d 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -1735,7 +1735,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
>  }
>  
>  static const char *sclk_parents[] = { "clk_m", "pll_c_out1", "pll_p_out4",
> -                              "pll_p_out3", "pll_p_out2", "unused",
> +                              "pll_p", "pll_p_out2", "unused",
>                                "clk_32k", "pll_m_out1" };
>  
>  static const char *cclk_g_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
> -- 
> 1.7.7.rc0.72.g4b5ea.dirty
