From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 27 Aug 2012 16:15:26 -0700
Subject: [PATCH v3 1/3] ARM: Samsung: Add support for MSHC controller
 clocks
In-Reply-To: <1345982371-26483-2-git-send-email-thomas.abraham@linaro.org>
References: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
 <1345982371-26483-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <503BFF8E.80503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/12 04:59, Thomas Abraham wrote:
> Add clock instances for bus interface unit clock and card interface unit
> clock of the all four MSHC controller instances.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c |   45 ++++++++++++----------------------
>   1 files changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index 3b00e29..16d8bef 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -564,35 +564,30 @@ static struct clk exynos5_init_clocks_off[] = {
>   		.enable		= exynos5_clk_ip_peris_ctrl,
>   		.ctrlbit	= (1<<  19),
>   	}, {
> -		.name		= "hsmmc",
> -		.devname	= "exynos4-sdhci.0",
> +		.name		= "biu",

I have no idea why we change the clock name to 'biu' (bus interface 
unit). Just let me know.

[...]

>   static struct clksrc_clk exynos5_clk_sclk_mmc0 = {
>   	.clk	= {
> -		.name		= "sclk_mmc",
> -		.devname	= "exynos4-sdhci.0",
> +		.name		= "ciu",

Same as above.

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
