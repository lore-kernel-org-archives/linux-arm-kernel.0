From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Wed, 18 Jul 2018 22:33:07 +0200
Subject: [PATCH] clk: samsung: Remove unused
 mout_user_aclk400_mcuisp_p4x12 variable
In-Reply-To: <20180718195620.5331-1-krzk@kernel.org>
References: <20180718195620.5331-1-krzk@kernel.org>
Message-ID: <c5e83bb8-840a-9e91-648c-4472b956c111@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speaking of the ISP clocks driver, I wonder why this one was never merged?
https://patches.linaro.org/patch/115531/

- Tobias


Krzysztof Kozlowski wrote:
> Remove unused 'mout_user_aclk400_mcuisp_p4x12' variable to fix GCC warning:
> 
>     drivers/clk/samsung/clk-exynos4412-isp.c:40:27: warning:
>         'mout_user_aclk400_mcuisp_p4x12' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos4412-isp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
> index d5f1ccb36300..cfaa057035ad 100644
> --- a/drivers/clk/samsung/clk-exynos4412-isp.c
> +++ b/drivers/clk/samsung/clk-exynos4412-isp.c
> @@ -37,8 +37,6 @@ static const unsigned long exynos4x12_clk_isp_save[] __initconst = {
>  	E4X12_GATE_ISP1,
>  };
>  
> -PNAME(mout_user_aclk400_mcuisp_p4x12) = { "fin_pll", "div_aclk400_mcuisp", };
> -
>  static struct samsung_div_clock exynos4x12_isp_div_clks[] = {
>  	DIV(CLK_ISP_DIV_ISP0, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
>  	DIV(CLK_ISP_DIV_ISP1, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
> 
