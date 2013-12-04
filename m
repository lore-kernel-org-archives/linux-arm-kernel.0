From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 4 Dec 2013 12:42:23 -0800
Subject: [PATCH v2] clk: exynos5420: fix cpll clock register offsets
In-Reply-To: <1380186395-28814-1-git-send-email-chander.kashyap@linaro.org>
References: <1380186395-28814-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CAPtuhTievddh8Z-DUYRCwoNeTtLVW+ucSJ+Kuf2u1pAPX4jxmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 2:06 AM, Chander Kashyap
<chander.kashyap@linaro.org> wrote:
> Fixes cpll control and lock register offset values for Exynos5420 SoC.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Taken into clk-next.

Thanks!
Mike

> ---
> Changes Since v1:
>         - Fixed patch subject as per Kukgin suggestion.
>
>  drivers/clk/samsung/clk-exynos5420.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 86dfc64..892aac0 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -730,8 +730,8 @@ struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>  struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
>         [apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
>                 APLL_CON0, NULL),
> -       [cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
> -               MPLL_CON0, NULL),
> +       [cpll] = PLL(pll_2550, fout_cpll, "fout_cpll", "fin_pll", CPLL_LOCK,
> +               CPLL_CON0, NULL),
>         [dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", DPLL_LOCK,
>                 DPLL_CON0, NULL),
>         [epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
> --
> 1.7.9.5
>
