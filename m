From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Apr 2014 17:48:21 +0200
Subject: [PATCH 2/4] clk: exynos4: export sclk_hdmiphy clock
In-Reply-To: <1396623201-26000-3-git-send-email-t.stanislaws@samsung.com>
References: <1396623201-26000-1-git-send-email-t.stanislaws@samsung.com>
 <1396623201-26000-3-git-send-email-t.stanislaws@samsung.com>
Message-ID: <53441A45.5080506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 04.04.2014 16:53, Tomasz Stanislawski wrote:
> Export sclk_hdmiphy clock to be usable from DT.
>
> Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos4.c   |    2 +-
>   include/dt-bindings/clock/exynos4.h |    1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index b4f9672..528f8eb 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -428,7 +428,7 @@ static struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata
>   /* fixed rate clocks generated inside the soc */
>   static struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] __initdata = {
>   	FRATE(0, "sclk_hdmi24m", NULL, CLK_IS_ROOT, 24000000),
> -	FRATE(0, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 27000000),
> +	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 27000000),
>   	FRATE(0, "sclk_usbphy0", NULL, CLK_IS_ROOT, 48000000),
>   };
>
> diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
> index 75aff33..0e245eb 100644
> --- a/include/dt-bindings/clock/exynos4.h
> +++ b/include/dt-bindings/clock/exynos4.h
> @@ -33,6 +33,7 @@
>   #define CLK_MOUT_MPLL_USER_C	18 /* Exynos4x12 only */
>   #define CLK_MOUT_CORE		19
>   #define CLK_MOUT_APLL		20
> +#define CLK_SCLK_HDMIPHY	22
>
>   /* gate for special clocks (sclk) */
>   #define CLK_SCLK_FIMC0		128
>

I believe this clock should be properly abstracted as an output of HDMI 
PHY, but I don't see any way to do this with existing infrastructure, so 
probably for now such workaround is fine.

Will apply, if nobody opposes.

Best regards,
Tomasz
