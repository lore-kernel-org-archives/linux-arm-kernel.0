From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Aug 2011 16:39:24 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix wrong pll type for vpll
In-Reply-To: <1313803628-32050-1-git-send-email-jhbird.choi@samsung.com>
References: <1313803628-32050-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <06c801cc6167$c7c739f0$5755add0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jhbird.choi at samsung.com wrote:
> 
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 851dea0..0b39860 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -1160,7 +1160,7 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
> 
>  	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
>  	vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
> -				__raw_readl(S5P_VPLL_CON1), pll_4650);
> +				__raw_readl(S5P_VPLL_CON1), pll_4650c);
> 
>  	clk_fout_apll.ops = &exynos4_fout_apll_ops;
>  	clk_fout_mpll.rate = mpll;
> --
> 1.7.0

Hi,

OK, will apply.

But would be helpful understanding if you could add git message in detail
like following...
"The PLL4650C is used for VPLL on EXYNOS4 so should be fixed"...I will add
this when apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
