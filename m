From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 05 Jan 2015 13:14:07 +0530
Subject: media: platform: s5p-jpeg: jpeg-hw-exynos4: Remove some unused
 functions
In-Reply-To: <1420231027-2714-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420231027-2714-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <54AA40C7.3000506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Tony Nadackal

Hi Rickard,

On Saturday 03 January 2015 02:07 AM, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> exynos4_jpeg_set_timer_count() exynos4_jpeg_get_frame_size() exynos4_jpeg_set_sys_int_enable() exynos4_jpeg_get_fifo_status()
>
> This was partially found by using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>
> ---
> drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c |   35 ---------------------
>   drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h |    5 ---
>   2 files changed, 40 deletions(-)
>
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> index ab6d6f4..5685577 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> @@ -163,15 +163,6 @@ unsigned int exynos4_jpeg_get_int_status(void __iomem *base)
>   	return int_status;
>   }
>
> -unsigned int exynos4_jpeg_get_fifo_status(void __iomem *base)
> -{
> -	unsigned int fifo_status;
> -
> -	fifo_status = readl(base + EXYNOS4_FIFO_STATUS_REG);
> -
> -	return fifo_status;
> -}
> -
>   void exynos4_jpeg_set_huf_table_enable(void __iomem *base, int value)
>   {
>   	unsigned int	reg;
> @@ -186,18 +177,6 @@ void exynos4_jpeg_set_huf_table_enable(void __iomem *base, int value)
>   					base + EXYNOS4_JPEG_CNTL_REG);
>   }
>
> -void exynos4_jpeg_set_sys_int_enable(void __iomem *base, int value)
> -{
> -	unsigned int	reg;
> -
> -	reg = readl(base + EXYNOS4_JPEG_CNTL_REG) & ~(EXYNOS4_SYS_INT_EN);
> -
> -	if (value == 1)
> -		writel(reg | EXYNOS4_SYS_INT_EN, base + EXYNOS4_JPEG_CNTL_REG);
> -	else
> -		writel(reg & ~EXYNOS4_SYS_INT_EN, base + EXYNOS4_JPEG_CNTL_REG);
> -}
> -

Above function will be needed for enabling JPEG support on Exynos7 SoC. 
There is already inflight patch [1] which will be using it.

1: https://patchwork.kernel.org/patch/5505391/


Thanks,
Pankaj Dubey
