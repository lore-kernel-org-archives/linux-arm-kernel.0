From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 06 Aug 2013 12:43:36 -0700
Subject: [PATCH 1/3] clk: exynos4: Make exynos4_plls static
In-Reply-To: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
References: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130806194336.5348.81505@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-08-06 04:31:13)
> 'exynos4_plls' is used only in this file. Make it static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Taken all three into clk-next. Seems like a lot of static-ization
patches for Exynos lately.

Regards,
Mike

> ---
>  drivers/clk/samsung/clk-exynos4.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 68f9a4a..fec319d 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -984,7 +984,7 @@ static __initdata struct of_device_id ext_clk_match[] = {
>         {},
>  };
>  
> -struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
> +static struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
>         [apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
>                 APLL_CON0, "fout_apll", NULL),
>         [mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
> -- 
> 1.7.9.5
