From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 07 Aug 2013 10:27:51 -0700
Subject: [PATCH 1/4] clk: exynos4: Fix incorrect placement of __initdata
In-Reply-To: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
References: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130807172751.5348.32832@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-08-06 21:48:37)
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied on top of the "[PATCH 1/3] clk: exynos4: Make exynos4_plls
static" series in clk-next.

Thanks for following up on this.

Regards,
Mike

> ---
>  drivers/clk/samsung/clk-exynos4.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index fec319d..742b4c5 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -194,7 +194,7 @@ enum exynos4_clks {
>   * list of controller registers to be saved and restored during a
>   * suspend/resume cycle.
>   */
> -static __initdata unsigned long exynos4210_clk_save[] = {
> +static unsigned long exynos4210_clk_save[] __initdata = {
>         E4210_SRC_IMAGE,
>         E4210_SRC_LCD1,
>         E4210_SRC_MASK_LCD1,
> @@ -205,7 +205,7 @@ static __initdata unsigned long exynos4210_clk_save[] = {
>         E4210_MPLL_CON0,
>  };
>  
> -static __initdata unsigned long exynos4x12_clk_save[] = {
> +static unsigned long exynos4x12_clk_save[] __initdata = {
>         E4X12_GATE_IP_IMAGE,
>         E4X12_GATE_IP_PERIR,
>         E4X12_SRC_CAM1,
> @@ -214,7 +214,7 @@ static __initdata unsigned long exynos4x12_clk_save[] = {
>         E4X12_MPLL_CON0,
>  };
>  
> -static __initdata unsigned long exynos4_clk_regs[] = {
> +static unsigned long exynos4_clk_regs[] __initdata = {
>         SRC_LEFTBUS,
>         DIV_LEFTBUS,
>         GATE_IP_LEFTBUS,
> @@ -978,13 +978,13 @@ static void __init exynos4_clk_register_finpll(unsigned long xom)
>  
>  }
>  
> -static __initdata struct of_device_id ext_clk_match[] = {
> +static struct of_device_id ext_clk_match[] __initdata = {
>         { .compatible = "samsung,clock-xxti", .data = (void *)0, },
>         { .compatible = "samsung,clock-xusbxti", .data = (void *)1, },
>         {},
>  };
>  
> -static struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
> +static struct samsung_pll_clock exynos4_plls[nr_plls] __initdata = {
>         [apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
>                 APLL_CON0, "fout_apll", NULL),
>         [mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
> -- 
> 1.7.9.5
