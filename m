From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 27 Aug 2012 16:11:32 -0700
Subject: [PATCH v3 2/3] ARM: Exynos5: Add AUXDATA support for MSHC
 controllers
In-Reply-To: <1345982371-26483-3-git-send-email-thomas.abraham@linaro.org>
References: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
 <1345982371-26483-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <503BFEA4.1070601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/12 04:59, Thomas Abraham wrote:
> Add entries if MSHC controllers in AUXDATA table for correct device name
> initialization.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/include/mach/map.h |    1 +
>   arch/arm/mach-exynos/mach-exynos5-dt.c  |    8 ++++++++
>   2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 9d1f3ac..5b0ee41 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -172,6 +172,7 @@
>
>   #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
>   #define EXYNOS4_PA_DWMCI		0x12550000
> +#define EXYNOS5_PA_DWMCI(x)		(0x12200000 + ((x) * 0x10000))

Just, how about EXYNOS5_PA_DWMMC0, EXYNOS5_PA_DWMMC1, ... EXYNOS_PA_DWMMC3?

And if the addresses are different on other EXYNOS5 SoC, how do we 
handle it for auxdata?

>
>   #define EXYNOS4_PA_HSOTG		0x12480000
>   #define EXYNOS4_PA_USB_HSPHY		0x125B0000
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index ef770bc..4257cc1 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -47,6 +47,14 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>   				"s3c2440-i2c.0", NULL),
>   	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
>   				"s3c2440-i2c.1", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(0),

As I commented, how about just 'samsung,dw-mmc'? but I'm not sure.

> +				"dw_mmc.0", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(1),
> +				"dw_mmc.1", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(2),
> +				"dw_mmc.2", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(3),
> +				"dw_mmc.3", NULL),
>   	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI0,
>   				"exynos4210-spi.0", NULL),
>   	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI1,

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
