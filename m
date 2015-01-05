From: tony.kn@samsung.com (Tony K Nadackal)
Date: Mon, 05 Jan 2015 10:41:55 +0530
Subject: [PATCH] [media] s5p-jpeg: Clear JPEG_CODEC_ON bits in sw reset
 function
In-Reply-To: <1418797339-27877-1-git-send-email-tony.kn@samsung.com>
References: <1418797339-27877-1-git-send-email-tony.kn@samsung.com>
Message-ID: <000001d028a6$2da27c90$88e775b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle Reminder.

Thanks
Tony

> -----Original Message-----
> From: Tony K Nadackal [mailto:tony.kn at samsung.com]
> Sent: Wednesday, December 17, 2014 11:52 AM
> To: linux-media at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> samsung-soc at vger.kernel.org
> Cc: mchehab at osg.samsung.com; j.anaszewski at samsung.com;
> kgene at kernel.org; k.debski at samsung.com; s.nawrocki at samsung.com;
> bhushan.r at samsung.com; Tony K Nadackal
> Subject: [PATCH] [media] s5p-jpeg: Clear JPEG_CODEC_ON bits in sw reset
> function
> 
> Bits EXYNOS4_DEC_MODE and EXYNOS4_ENC_MODE do not get cleared on
> software reset. These bits need to be cleared explicitly.
> 
> Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
> ---
> This patch is created and tested on top of linux-next-20141210.
> It can be cleanly applied on media-next and kgene/for-next.
> 
> 
>  drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> index ab6d6f43..e53f13a 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> @@ -21,6 +21,10 @@ void exynos4_jpeg_sw_reset(void __iomem *base)
>  	unsigned int reg;
> 
>  	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
> +	writel(reg & ~(EXYNOS4_DEC_MODE | EXYNOS4_ENC_MODE),
> +				base + EXYNOS4_JPEG_CNTL_REG);
> +
> +	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
>  	writel(reg & ~EXYNOS4_SOFT_RESET_HI, base +
> EXYNOS4_JPEG_CNTL_REG);
> 
>  	udelay(100);
> --
> 2.2.0
