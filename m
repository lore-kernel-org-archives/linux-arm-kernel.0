From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Mar 2011 10:53:05 +0900
Subject: [PATCH v3] ARM: EXYNOS4: add support for i2c PMICs on
	Universal_C210	board
In-Reply-To: <1299164371-23398-1-git-send-email-m.szyprowski@samsung.com>
References: <018901cbd949$c86e8f80$594bae80$%kim@samsung.com>
	<1299164371-23398-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <022f01cbda0e$ea1d30d0$be579270$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds basic definitions for MAX8952 & LP3974 (MAX8998
> compatible) PMICs for UniversalC210 board. Power consumers for the
> device drivers will be added later. These two PMICs occupy I2C5 bus.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig               |    2 +
>  arch/arm/mach-exynos4/mach-universal_c210.c |  413
> +++++++++++++++++++++++++++
>  2 files changed, 415 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index ad03840..d58cbb5 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -116,8 +116,10 @@ config MACH_UNIVERSAL_C210
>  	select S3C_DEV_HSMMC2
>  	select S3C_DEV_HSMMC3
>  	select S3C_DEV_I2C1
> + 	select S3C_DEV_I2C5
   ^
Used 1 white space + tab here.
As you know, just 1 tab is enough :)

>  	select S5P_DEV_ONENAND
>  	select EXYNOS4_SETUP_I2C1
> + 	select EXYNOS4_SETUP_I2C5
   ^
Same as above.

>  	select EXYNOS4_SETUP_SDHCI
>  	help
>  	  Machine support for Samsung Mobile Universal S5PC210 Reference

Thanks for your re-working.
Ok, will apply with above fixing.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
