From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 19:49:25 +0200
Subject: [PATCH v4 14/15] clk: exynos5420: add misc clocks
In-Reply-To: <1399393610-23394-15-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
 <1399393610-23394-15-git-send-email-shaik.ameer@samsung.com>
Message-ID: <536920A5.1090502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shaik,

On 06.05.2014 18:26, Shaik Ameer Basha wrote:
> This patch adds some missing miscellaneous clocks specific
> to exynos5420.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c   |   14 +++++++++++---
>   include/dt-bindings/clock/exynos5420.h |    2 ++
>   2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index e0e749d..e69e820 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -273,7 +273,8 @@ PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
>
>   PNAME(mout_fimd1_final_p) = {"mout_fimd1", "mout_fimd1_opt"};
>   PNAME(mout_sw_aclk66_p)	= {"dout_aclk66", "mout_sclk_spll"};
> -PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66" };
> +PNAME(mout_user_aclk66_peric_p)	= { "fin_pll", "mout_sw_aclk66"};
> +PNAME(mout_user_pclk66_gpio_p) = {"mout_sw_aclk66", "ffactor_sw_aclk66"};
>
>   PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
>   PNAME(mout_sw_pclk200_fsys_p) = {"dout_pclk200_fsys", "mout_sclk_spll"};
> @@ -372,10 +373,13 @@ static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata =
>   };
>
>   static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
> -	FFACTOR(0, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
> +	FFACTOR(0, "ffactor_hsic_12m", "fin_pll", 1, 2, 0),
> +	FFACTOR(0, "ffactor_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),

Is the "ffactor_" prefix also present in the datasheet? If not, it 
should be removed from clock names as well.

Best regards,
Tomasz
