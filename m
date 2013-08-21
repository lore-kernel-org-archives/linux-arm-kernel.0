From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Wed, 21 Aug 2013 18:04:07 +0530
Subject: [PATCH 14/16] clk: samsung: exynos4: Register PLL rate tables for
 Exynos4210
In-Reply-To: <1377019903-14614-15-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
 <1377019903-14614-15-git-send-email-t.figa@samsung.com>
Message-ID: <CAKew6eXbc8ai9vSX2EMv+=7LYmxZ+75z1X72ytULOxtwX7bebg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:01 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch adds rate tables for PLLs that can be reconfigured at runtime
> for Exynos4210 SoCs. Provided tables contain PLL coefficients for
> input clock of 24 MHz and so are registered only in this case. MPLL does
> not need runtime reconfiguration and so table for it is not provided.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c | 45 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 34474ce..e18cfae 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -992,6 +992,40 @@ static struct of_device_id ext_clk_match[] __initdata = {
>         {},
>  };
>
> +/* PLLs PMS values */
> +static struct samsung_pll_rate_table exynos4210_apll_rates[] = {
> +       PLL_45XX_RATE(1200000000, 150,  3, 1, 28),

All these tables in this patch as well as next patch can be __initdata


Regards,
Yadwinder
