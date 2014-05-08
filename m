From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 08 May 2014 19:32:52 +0200
Subject: [PATCH] clk: exynos5420: Add clock IDs needed by GPU
In-Reply-To: <1398680444-12400-1-git-send-email-arun.kk@samsung.com>
References: <1398680444-12400-1-git-send-email-arun.kk@samsung.com>
Message-ID: <536BBFC4.2030103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On 28.04.2014 12:20, Arun Kumar K wrote:
> Adds IDs for the clocks needed by the ARM Mali GPU
> in exynos5420.
> 
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c   |    4 ++--
>  include/dt-bindings/clock/exynos5420.h |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 60b2681..7a9e3b4 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -362,7 +362,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>  	MUX(0, "mout_aclk66_psgen", aclk66_peric_p, SRC_TOP5, 4, 1),
>  	MUX(0, "mout_user_aclk333_g2d", user_aclk333_g2d_p, SRC_TOP5, 8, 1),
>  	MUX(0, "mout_user_aclk266_g2d", user_aclk266_g2d_p, SRC_TOP5, 12, 1),
> -	MUX_A(0, "mout_user_aclk_g3d", user_aclk_g3d_p,
> +	MUX_A(CLK_MOUT_G3D, "mout_user_aclk_g3d", user_aclk_g3d_p,
>  			SRC_TOP5, 16, 1, "aclkg3d"),
>  	MUX(0, "mout_user_aclk300_jpeg", user_aclk300_jpeg_p,
>  			SRC_TOP5, 20, 1),
> @@ -372,7 +372,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>  			SRC_TOP5, 28, 1),
>  
>  	MUX(0, "sclk_mpll", mpll_p, SRC_TOP6, 0, 1),
> -	MUX(0, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
> +	MUX(CLK_MOUT_VPLL, "sclk_vpll", vpll_p, SRC_TOP6, 4, 1),
>  	MUX(0, "sclk_spll", spll_p, SRC_TOP6, 8, 1),
>  	MUX(0, "sclk_ipll", ipll_p, SRC_TOP6, 12, 1),
>  	MUX(0, "sclk_rpll", rpll_p, SRC_TOP6, 16, 1),
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 5eefd88..54db8b3 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -178,6 +178,8 @@
>  
>  /* mux clocks */
>  #define CLK_MOUT_HDMI		640
> +#define CLK_MOUT_G3D		641
> +#define CLK_MOUT_VPLL		642
>  
>  /* divider clocks */
>  #define CLK_DOUT_PIXEL		768
> 

Applied to samsung-clk/samsung-next.

Best regards,
Tomasz
