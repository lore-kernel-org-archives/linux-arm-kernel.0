From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 23 Jul 2012 17:34:19 +0900
Subject: [PATCH V2 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
Message-ID: <500D0C8B.3080007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 02:57 PM, Leela Krishna Amudala wrote:
> This patch adds the bus clock for FIMD and changes
> the device name for lcd clock

Please refer below patch for exynos4.

http://lists.linaro.org/pipermail/linaro-dev/2011-December/008872.html

> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index 774533c..f001876 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -634,6 +634,11 @@ static struct clk exynos5_init_clocks_off[] = {
>   		.enable		= exynos5_clk_ip_disp1_ctrl,
>   		.ctrlbit	= (1 << 3),
>   	}, {
> +		.name           = "fimd",
> +		.devname        = "exynos5-fb",
> +		.enable         = exynos5_clk_ip_disp1_ctrl,
> +		.ctrlbit        = (1 << 0),
> +	}, {
>   		.name		= "iis",
>   		.devname	= "samsung-i2s.1",
>   		.enable		= exynos5_clk_ip_peric_ctrl,
> @@ -1132,7 +1137,7 @@ static struct clksrc_clk exynos5_clksrcs[] = {
>   	}, {
>   		.clk	= {
>   			.name		= "sclk_fimd",
> -			.devname	= "s3cfb.1",
> +			.devname	= "exynos5-fb",
>   			.enable		= exynos5_clksrc_mask_disp1_0_ctrl,
>   			.ctrlbit	= (1 << 0),
>   		},
