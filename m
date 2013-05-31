From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 31 May 2013 12:23:06 -0700
Subject: [PATCH] clk: tegra: fix clk_out parents list
In-Reply-To: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
References: <1369641279-6894-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130531192306.21525.67464@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Prashant Gaikwad (2013-05-27 00:54:39)
> Number of parents for clk_out_2 and clk_out_3 was incorrectly set
> to clk_out1_parents. Even though it did not break anything since the
> size was same better to fix.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

Taken into clk-next since this fix doesn't appear to fix anything.

Thanks,
Mike

> ---
>  drivers/clk/tegra/clk-tegra114.c |    4 ++--
>  drivers/clk/tegra/clk-tegra30.c  |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index e0ee077..6d438bb 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -1602,7 +1602,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
>  
>         /* clk_out_2 */
>         clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
> -                              ARRAY_SIZE(clk_out1_parents), 0,
> +                              ARRAY_SIZE(clk_out2_parents), 0,
>                                pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
>                                &clk_out_lock);
>         clks[clk_out_2_mux] = clk;
> @@ -1614,7 +1614,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
>  
>         /* clk_out_3 */
>         clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
> -                              ARRAY_SIZE(clk_out1_parents), 0,
> +                              ARRAY_SIZE(clk_out3_parents), 0,
>                                pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
>                                &clk_out_lock);
>         clks[clk_out_3_mux] = clk;
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index 985ad69..b62e140 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -1223,7 +1223,7 @@ static void __init tegra30_pmc_clk_init(void)
>  
>         /* clk_out_2 */
>         clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
> -                              ARRAY_SIZE(clk_out1_parents), 0,
> +                              ARRAY_SIZE(clk_out2_parents), 0,
>                                pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
>                                &clk_out_lock);
>         clk = clk_register_gate(NULL, "clk_out_2", "clk_out_2_mux", 0,
> @@ -1234,7 +1234,7 @@ static void __init tegra30_pmc_clk_init(void)
>  
>         /* clk_out_3 */
>         clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
> -                              ARRAY_SIZE(clk_out1_parents), 0,
> +                              ARRAY_SIZE(clk_out3_parents), 0,
>                                pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
>                                &clk_out_lock);
>         clk = clk_register_gate(NULL, "clk_out_3", "clk_out_3_mux", 0,
> -- 
> 1.7.4.1
