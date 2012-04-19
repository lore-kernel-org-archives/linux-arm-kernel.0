From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 17:23:50 -0700
Subject: [PATCH 12/12] ARM: Exynos5: Update device tree enabled machine
 file
In-Reply-To: <1334641595-25301-13-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-13-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F8F5B16.7000501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> Add AUXDATA for i2c and MDMA controllers of Exynos5.
> 
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/mach-exynos5-dt.c |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index 4711c89..8adc061 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -43,9 +43,14 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>   				"exynos4210-uart.2", NULL),
>   	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART3,
>   				"exynos4210-uart.3", NULL),
> +	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(0),
> +				"s3c2440-i2c.0", NULL),
> +	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
> +				"s3c2440-i2c.1", NULL),
>   	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
>   	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
> -	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
> +	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA0, "dma-pl330.2", NULL),
> +	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.3", NULL),

Probably, you missed my comments on your previous patches. Fixed on rc3.

So just need to update i2c stuff now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
