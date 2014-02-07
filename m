From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 07 Feb 2014 10:50:26 +0100
Subject: [PATCH v2 7/9] clk: samsung: Drop old suspend/resume code
In-Reply-To: <1391710616-14226-8-git-send-email-t.figa@samsung.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
 <1391710616-14226-8-git-send-email-t.figa@samsung.com>
Message-ID: <4274393.fPXjFZLa78@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. Februar 2014, 19:16:54 schrieb Tomasz Figa:
> Since all SoC drivers have been moved to local suspend/resume handling,
> the old code can be safely dropped.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

So it looks like I'll need to respin my s3c24xx-ccf patches again, but 
nevertheless:

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/clk/samsung/clk-exynos4.c    |  2 +-
>  drivers/clk/samsung/clk-exynos5250.c |  2 +-
>  drivers/clk/samsung/clk-exynos5420.c |  2 +-
>  drivers/clk/samsung/clk-exynos5440.c |  2 +-
>  drivers/clk/samsung/clk-s3c64xx.c    |  2 +-
>  drivers/clk/samsung/clk.c            | 54
> +----------------------------------- drivers/clk/samsung/clk.h            |
>  4 +--
>  7 files changed, 7 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c
> b/drivers/clk/samsung/clk-exynos4.c index 325f292..b620a83 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -1122,7 +1122,7 @@ static void __init exynos4_clk_init(struct device_node
> *np, if (!reg_base)
>  		panic("%s: failed to map registers\n", __func__);
> 
> -	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
> +	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
> 
>  	samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
> diff --git a/drivers/clk/samsung/clk-exynos5250.c
> b/drivers/clk/samsung/clk-exynos5250.c index b3cccf0..e7ee442 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -694,7 +694,7 @@ static void __init exynos5250_clk_init(struct
> device_node *np) panic("%s: unable to determine soc\n", __func__);
>  	}
> 
> -	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
> +	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
>  	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
>  			ext_clk_match);
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
> b/drivers/clk/samsung/clk-exynos5420.c index 8ce0780..60b2681 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -786,7 +786,7 @@ static void __init exynos5420_clk_init(struct
> device_node *np) panic("%s: unable to determine soc\n", __func__);
>  	}
> 
> -	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
> +	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
>  	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
>  			ext_clk_match);
> diff --git a/drivers/clk/samsung/clk-exynos5440.c
> b/drivers/clk/samsung/clk-exynos5440.c index cbc15b5..2bfad5a 100644
> --- a/drivers/clk/samsung/clk-exynos5440.c
> +++ b/drivers/clk/samsung/clk-exynos5440.c
> @@ -101,7 +101,7 @@ static void __init exynos5440_clk_init(struct
> device_node *np) return;
>  	}
> 
> -	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
> +	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
>  	samsung_clk_of_register_fixed_ext(exynos5440_fixed_rate_ext_clks,
>  		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
> 
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c
> b/drivers/clk/samsung/clk-s3c64xx.c index d3fbfa5..8bda658 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c
> @@ -465,7 +465,7 @@ void __init s3c64xx_clk_init(struct device_node *np,
> unsigned long xtal_f, panic("%s: failed to map registers\n", __func__);
>  	}
> 
> -	samsung_clk_init(np, reg_base, NR_CLKS, NULL, 0, NULL, 0);
> +	samsung_clk_init(np, reg_base, NR_CLKS);
> 
>  	/* Register external clocks. */
>  	if (!np)
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index ec761e3..91bec3e 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -21,7 +21,6 @@ static void __iomem *reg_base;
>  static struct clk_onecell_data clk_data;
>  #endif
> 
> -#ifdef CONFIG_PM_SLEEP
>  void samsung_clk_save(void __iomem *base,
>  				    struct samsung_clk_reg_dump *rd,
>  				    unsigned int num_regs)
> @@ -55,63 +54,12 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
> return rd;
>  }
> 
> -static struct samsung_clk_reg_dump *reg_dump;
> -static unsigned long nr_reg_dump;
> -
> -static int samsung_clk_suspend(void)
> -{
> -	struct samsung_clk_reg_dump *rd = reg_dump;
> -	unsigned long i;
> -
> -	for (i = 0; i < nr_reg_dump; i++, rd++)
> -		rd->value = __raw_readl(reg_base + rd->offset);
> -
> -	return 0;
> -}
> -
> -static void samsung_clk_resume(void)
> -{
> -	struct samsung_clk_reg_dump *rd = reg_dump;
> -	unsigned long i;
> -
> -	for (i = 0; i < nr_reg_dump; i++, rd++)
> -		__raw_writel(rd->value, reg_base + rd->offset);
> -}
> -
> -static struct syscore_ops samsung_clk_syscore_ops = {
> -	.suspend	= samsung_clk_suspend,
> -	.resume		= samsung_clk_resume,
> -};
> -#endif /* CONFIG_PM_SLEEP */
> -
>  /* setup the essentials required to support clock lookup using ccf */
>  void __init samsung_clk_init(struct device_node *np, void __iomem *base,
> -		unsigned long nr_clks, unsigned long *rdump,
> -		unsigned long nr_rdump, unsigned long *soc_rdump,
> -		unsigned long nr_soc_rdump)
> +			     unsigned long nr_clks)
>  {
>  	reg_base = base;
> 
> -#ifdef CONFIG_PM_SLEEP
> -	if (rdump && nr_rdump) {
> -		unsigned int idx;
> -		reg_dump = kzalloc(sizeof(struct samsung_clk_reg_dump)
> -				* (nr_rdump + nr_soc_rdump), GFP_KERNEL);
> -		if (!reg_dump) {
> -			pr_err("%s: memory alloc for register dump failed\n",
> -					__func__);
> -			return;
> -		}
> -
> -		for (idx = 0; idx < nr_rdump; idx++)
> -			reg_dump[idx].offset = rdump[idx];
> -		for (idx = 0; idx < nr_soc_rdump; idx++)
> -			reg_dump[nr_rdump + idx].offset = soc_rdump[idx];
> -		nr_reg_dump = nr_rdump + nr_soc_rdump;
> -		register_syscore_ops(&samsung_clk_syscore_ops);
> -	}
> -#endif
> -
>  	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>  	if (!clk_table)
>  		panic("could not allocate clock lookup table\n");
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index 93cb8a0..c7141ba 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -313,9 +313,7 @@ struct samsung_pll_clock {
>  		_lock, _con, _rtable, _alias)
> 
>  extern void __init samsung_clk_init(struct device_node *np, void __iomem
> *base, -		unsigned long nr_clks, unsigned long *rdump,
> -		unsigned long nr_rdump, unsigned long *soc_rdump,
> -		unsigned long nr_soc_rdump);
> +				    unsigned long nr_clks);
>  extern void __init samsung_clk_of_register_fixed_ext(
>  		struct samsung_fixed_rate_clock *fixed_rate_clk,
>  		unsigned int nr_fixed_rate_clk,
