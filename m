From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 May 2012 16:30:04 +0900
Subject: [PATCH 2/6] ARM: Exynos5: Add spi clock support
In-Reply-To: <1337334392-6441-3-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <006b01cd397f$09784840$1c68d8c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> Add support for clock instances for each spi controller.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
> ---
>  arch/arm/mach-exynos/clock-exynos5.c           |   98
> ++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/regs-clock.h |    4 +
>  2 files changed, 102 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-
> exynos/clock-exynos5.c
> index 5aa460b..ad6c959 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -82,6 +82,11 @@ static int exynos5_clksrc_mask_peric0_ctrl(struct clk
> *clk, int enable)
>  	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC0, clk, enable);
>  }
> 
> +static int exynos5_clksrc_mask_peric1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC1, clk, enable);
> +}
> +
>  static int exynos5_clk_ip_acp_ctrl(struct clk *clk, int enable)
>  {
>  	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_ACP, clk, enable);
> @@ -692,6 +697,24 @@ static struct clk exynos5_init_clocks_off[] = {
>  		.enable		= exynos5_clk_ip_peric_ctrl,
>  		.ctrlbit	= (1 << 14),
>  	}, {
> +		.name		= "spi",
> +		.devname	= "exynos4210-spi.0",
> +		.parent		= &exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1 << 16),
> +	}, {
> +		.name		= "spi",
> +		.devname	= "exynos4210-spi.1",
> +		.parent		= &exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1 << 17),
> +	}, {
> +		.name		= "spi",
> +		.devname	= "exynos4210-spi.2",
> +		.parent		= &exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1 << 18),
> +	}, {
>  		.name		= SYSMMU_CLOCK_NAME,
>  		.devname	= SYSMMU_CLOCK_DEVNAME(mfc_l, 0),
>  		.enable		= &exynos5_clk_ip_mfc_ctrl,
> @@ -985,6 +1008,72 @@ static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
>  	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 24, .size = 8 },
>  };
> 
> +static struct clksrc_clk exynos5_clk_mdout_spi0 = {

See the previous comments and below url.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/083153.h
tml

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
