From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 13:31:04 +0530
Subject: [PATCH 1/1] clk: exynos5420: Staticize local variables
In-Reply-To: <1400673482-16287-1-git-send-email-sachin.kamat@linaro.org>
References: <1400673482-16287-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHwzAsJLfYfn_ZfyEx+jerntZOn3fBG682M08hN+DR+sCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 17:28, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Local symbols are made static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos5420.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 9d7d7eed03fd..41b507baf5d6 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -474,7 +474,7 @@ static struct samsung_fixed_factor_clock
>         FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>  };
>
> -struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
> +static struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
>         MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
>         MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
>         MUX(0, "mout_aclk400_wcore", mout_group2_5800_p, SRC_TOP0, 16, 3),
> @@ -523,7 +523,7 @@ struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
>         MUX(0, "mout_fimd1", mout_group2_p, SRC_DISP10, 4, 3),
>  };
>
> -struct samsung_div_clock exynos5800_div_clks[] __initdata = {
> +static struct samsung_div_clock exynos5800_div_clks[] __initdata = {
>         DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore", DIV_TOP0, 16, 3),
>
>         DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
> @@ -539,14 +539,14 @@ struct samsung_div_clock exynos5800_div_clks[] __initdata = {
>         DIV(0, "dout_sclk_sw", "sclk_spll", DIV_TOP9, 24, 6),
>  };
>
> -struct samsung_gate_clock exynos5800_gate_clks[] __initdata = {
> +static struct samsung_gate_clock exynos5800_gate_clks[] __initdata = {
>         GATE(CLK_ACLK550_CAM, "aclk550_cam", "mout_user_aclk550_cam",
>                                 GATE_BUS_TOP, 24, 0, 0),
>         GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
>                                 GATE_BUS_TOP, 27, 0, 0),
>  };
>
> -struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
> +static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>         MUX(0, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
>         MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
>                                 TOP_SPARE2, 4, 1),
> @@ -576,7 +576,7 @@ struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>         MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
>  };
>
> -struct samsung_div_clock exynos5420_div_clks[] __initdata = {
> +static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>         DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
>                         DIV_TOP0, 16, 3),
>  };
> --

Mike,

Tomasz is probably on vacation. Can you please take this patch?

-- 
With warm regards,
Sachin
