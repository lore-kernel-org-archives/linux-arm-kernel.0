From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 07:57:25 +0900
Subject: [PATCH v3 4/6] ARM: S5P: Add EPLL rate change warning
In-Reply-To: <1286963468-17469-1-git-send-email-sw.youn@samsung.com>
References: <1286963468-17469-1-git-send-email-sw.youn@samsung.com>
Message-ID: <003401cb6b2a$0267d9f0$07378dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwhan Youn wrote:
> 
> This patch adds warning about changing EPLL rate to notice that other
> driver that controls H/W, which is using EPLL, will has unknown effects
> by this EPLL rate change.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
> This patch is re-worked to avoid conflict with previous re-worked patch(
> [PATCH v3 1/6] ARM: S5P: Reduce duplicated EPLL control codes).
> 
> This patch also depends on previous v1 and v2 petch-set which was
accepted,
> and depends on re-workd patch v3 1/6.
> --
>  arch/arm/mach-s5p64x0/clock-s5p6440.c |    3 +++
>  arch/arm/mach-s5p64x0/clock-s5p6450.c |    3 +++
>  arch/arm/mach-s5pc100/clock.c         |    3 +++
>  arch/arm/mach-s5pv210/clock.c         |    3 +++
>  4 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
> s5p64x0/clock-s5p6440.c
> index cfccdff..0d728d3 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> @@ -79,6 +79,9 @@ static int s5p6440_epll_set_rate(struct clk *clk,
unsigned long
> rate)
>  	__raw_writel(epll_con, S5P64X0_EPLL_CON);
>  	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
> 
> +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> +			clk->rate, rate);
> +
>  	clk->rate = rate;
> 
>  	return 0;
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-
> s5p64x0/clock-s5p6450.c
> index f1498d3..1b9b0f9 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
> @@ -80,6 +80,9 @@ static int s5p6450_epll_set_rate(struct clk *clk,
unsigned long
> rate)
>  	__raw_writel(epll_con, S5P64X0_EPLL_CON);
>  	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
> 
> +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> +			clk->rate, rate);
> +
>  	clk->rate = rate;
> 
>  	return 0;
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> index 42c2636..9e192a0 100644
> --- a/arch/arm/mach-s5pc100/clock.c
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -323,6 +323,9 @@ static int s5pc100_epll_set_rate(struct clk *clk,
unsigned
> long rate)
> 
>  	__raw_writel(epll_con, S5P_EPLL_CON);
> 
> +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> +			clk->rate, rate);
> +
>  	clk->rate = rate;
> 
>  	return 0;
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index fdfadac..25eb839 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -1066,6 +1066,9 @@ static int s5pv210_epll_set_rate(struct clk *clk,
unsigned
> long rate)
>  	__raw_writel(epll_con, S5P_EPLL_CON);
>  	__raw_writel(epll_con_k, S5P_EPLL_CON1);
> 
> +	printk(KERN_WARNING "EPLL Rate changes from %lu to %lu\n",
> +			clk->rate, rate);
> +
>  	clk->rate = rate;
> 
>  	return 0;
> --

Thanks for your rebase.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
