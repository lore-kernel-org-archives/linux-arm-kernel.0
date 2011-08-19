From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 14:24:09 +0900
Subject: [PATCH] ARM: S5P64X0: Add the devname for DMA clock
In-Reply-To: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
References: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <000601cc5e30$3a38bda0$aeaa38e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boojin Kim wrote:
> 
> This patch adds devname for DMA clock.
> NOTE: This patch should be added after merging new pl330 driver on
dmaengine.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/clock-s5p6440.c |    1 +
>  arch/arm/mach-s5p64x0/clock-s5p6450.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
> s5p64x0/clock-s5p6440.c
> index c1f548f..c54c65d 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> @@ -147,6 +147,7 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 8),
>  	}, {
>  		.name		= "dma",
> +		.devname	= "dma-pl330",
>  		.parent		= &clk_hclk_low.clk,
>  		.enable		= s5p64x0_hclk0_ctrl,
>  		.ctrlbit	= (1 << 12),
> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-
> s5p64x0/clock-s5p6450.c
> index 3d9b609..2d04abf 100644
> --- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
> +++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
> @@ -180,6 +180,7 @@ static struct clk init_clocks_off[] = {
>  		.ctrlbit	= (1 << 3),
>  	}, {
>  		.name		= "dma",
> +		.devname	= "dma-pl330",
>  		.parent		= &clk_hclk_low.clk,
>  		.enable		= s5p64x0_hclk0_ctrl,
>  		.ctrlbit	= (1 << 12),
> --
> 1.7.1

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
