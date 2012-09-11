From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 11 Sep 2012 09:22:45 +0900
Subject: [PATCH] ARM: EXYNOS5: Add bus clock and set parent clock for FIMD
In-Reply-To: <1347307866-30641-1-git-send-email-l.krishna@samsung.com>
References: <1347307866-30641-1-git-send-email-l.krishna@samsung.com>
Message-ID: <000101cd8fb3$90d10db0$b2732910$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 11, 2012 5:11 AM Leela Krishna Amudala wrote
> 
> This patch adds the bus clock for FIMD and changes the device name for lcd clock
> also sets mout_mpll_user as parent clock to fimd
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/mach-exynos/clock-exynos5.c       |   34 +++++++++++++++++++--------
>  arch/arm/plat-samsung/include/plat/clock.h |    2 +
>  2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index 774533c..f1281cf 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -891,6 +891,13 @@ static struct clk exynos5_clk_mdma1 = {
>  	.ctrlbit	= (1 << 4),
>  };
> 
> +static struct clk exynos5_clk_fimd = {
> +	.name		= "fimd",
> +	.devname	= "exynos5-fb",


Replace 'exynos5-fb' with 'exynos5-fb.1', as exynos4 fimd uses exynos4-fb.0
as devname. Exynos5 can use fimd0 or fimd1. Also, Exynos5250 uses fimd1.


> +	.enable		= exynos5_clk_ip_disp1_ctrl,
> +	.ctrlbit	= (1 << 0),
> +};
> +
