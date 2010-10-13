From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Oct 2010 17:06:33 +0900
Subject: [PATCH v2 2/6] ARM: S5PV210: Fix wrong EPLL rate getting on setup
	clocks
In-Reply-To: <1286883379-27688-1-git-send-email-sw.youn@samsung.com>
References: <1286883379-27688-1-git-send-email-sw.youn@samsung.com>
Message-ID: <002501cb6aad$8f1efbd0$ad5cf370$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwhan Youn wrote:
> 
> This patch fix wrong EPLL getting on setup clocks on S5PV210.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c                   |    3 ++-
>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 3f3b7ba..f1ec5bb 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -1040,7 +1040,8 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
> 
>  	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
>  	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
> -	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
> +	epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON),
> +				__raw_readl(S5P_EPLL_CON1), pll_4600);
>  	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
>  	vpll = s5p_get_pll45xx(vpllsrc, __raw_readl(S5P_VPLL_CON),
pll_4502);
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
b/arch/arm/mach-
> s5pv210/include/mach/regs-clock.h
> index 929fd3a..eaca7bc 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> @@ -25,6 +25,7 @@
>  #define S5P_APLL_CON		S5P_CLKREG(0x100)
>  #define S5P_MPLL_CON		S5P_CLKREG(0x108)
>  #define S5P_EPLL_CON		S5P_CLKREG(0x110)
> +#define S5P_EPLL_CON1		S5P_CLKREG(0x114)
>  #define S5P_VPLL_CON		S5P_CLKREG(0x120)
> 
>  #define S5P_CLK_SRC0		S5P_CLKREG(0x200)
> --
Ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
