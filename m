From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 01 Feb 2012 08:21:41 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: Enable MDMA driver
In-Reply-To: <1328025437-5396-2-git-send-email-kgene.kim@samsung.com>
References: <1328025437-5396-1-git-send-email-kgene.kim@samsung.com>
 <1328025437-5396-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F28A8BD.9000601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2012 09:27 PM, Kukjin Kim wrote:
> From: Boojin Kim <boojin.kim@samsung.com>
> 
> This patch adds MDMA platform data and enables
> MDMA for DMA memcpy operation for EXYNOS SoCs.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/clock-exynos4.c           |    9 ++++++
>  arch/arm/mach-exynos/dma.c                     |   35 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
>  arch/arm/mach-exynos/include/mach/map.h        |    3 +-
>  arch/arm/plat-samsung/include/plat/dma-pl330.h |    8 +++++
>  5 files changed, 56 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
> index 411b366b..ffcc46b 100644
> --- a/arch/arm/mach-exynos/clock-exynos4.c
> +++ b/arch/arm/mach-exynos/clock-exynos4.c
> @@ -783,6 +783,13 @@ static struct clk exynos4_clk_pdma1 = {
>  	.ctrlbit	= (1 << 1),
>  };
>  
> +static struct clk exynos4_clk_mdma1 = {

exynos4_clk_mdma ?

> +	.name		= "dma",
> +	.devname	= "dma-pl330.2",
> +	.enable		= exynos4_clk_ip_image_ctrl,
> +	.ctrlbit	= ((1 << 8) | (1 << 5) | (1 << 2)),
> +};
> +
>  struct clk *exynos4_clkset_group_list[] = {
>  	[0] = &clk_ext_xtal_mux,
>  	[1] = &clk_xusbxti,
> @@ -1301,6 +1308,7 @@ static struct clksrc_clk *exynos4_sysclks[] = {
>  static struct clk *exynos4_clk_cdev[] = {
>  	&exynos4_clk_pdma0,
>  	&exynos4_clk_pdma1,
> +	&exynos4_clk_mdma,
>  };
>  
>  static struct clksrc_clk *exynos4_clksrc_cdev[] = {
> @@ -1329,6 +1337,7 @@ static struct clk_lookup exynos4_clk_lookup[] = {
>  	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &exynos4_clk_sclk_mmc3.clk),
>  	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos4_clk_pdma0),
>  	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos4_clk_pdma1),
> +	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos4_clk_mdma),
>  	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
>  	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
>  	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),


-- 
Tushar Behera
