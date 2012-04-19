From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 17:30:46 -0700
Subject: [PATCH 04/12] ARM: Exynos5: Remove duplicated instantiation of
 pdma clock
In-Reply-To: <1334641595-25301-5-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F8F5CB6.4080505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> The clock of both the peripheral dma controllers is controlled by a single
> clock gate. Hence remove the duplicate instantiation of the pdma clock.
> 
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c |   17 ++++-------------
>   1 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index 662615d..fb95e9b 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -762,16 +762,8 @@ static struct clk exynos5_init_clocks_on[] = {
>   	}
>   };
> 
> -static struct clk exynos5_clk_pdma0 = {
> +static struct clk exynos5_clk_pdma = {
>   	.name		= "dma",
> -	.devname	= "dma-pl330.0",
> -	.enable		= exynos5_clk_ip_fsys_ctrl,
> -	.ctrlbit	= (1<<  1),
> -};
> -
> -static struct clk exynos5_clk_pdma1 = {
> -	.name		= "dma",
> -	.devname	= "dma-pl330.1",
>   	.enable		= exynos5_clk_ip_fsys_ctrl,
>   	.ctrlbit	= (1<<  1),

Since this shuld be (1 << 2), this patch can be dropped.

As I know, Boojin's patch fixes this. If not, please fix this :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
