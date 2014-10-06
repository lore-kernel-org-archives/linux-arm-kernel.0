From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 06 Oct 2014 17:52:07 +0200
Subject: [PATCH] [media] Remove references to non-existent PLAT_S5P symbol
In-Reply-To: <1412609947-8358-1-git-send-email-s.nawrocki@samsung.com>
References: <1412609947-8358-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5432BAA7.4010008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.2014 17:39, Sylwester Nawrocki wrote:
> diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
> index 77c9512..b3b270a 100644
> --- a/drivers/media/platform/exynos4-is/Kconfig
> +++ b/drivers/media/platform/exynos4-is/Kconfig
> @@ -2,7 +2,7 @@
>  config VIDEO_SAMSUNG_EXYNOS4_IS
>  	bool "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
>  	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
> -	depends on (PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST)
> +	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>  	depends on OF && COMMON_CLK
>  	help
>  	  Say Y here to enable camera host interface devices for
> @@ -57,7 +57,7 @@ endif
>  
>  config VIDEO_EXYNOS4_FIMC_IS
>  	tristate "EXYNOS4x12 FIMC-IS (Imaging Subsystem) driver"
> -	depends on HAS_DMA
> +	depends on HAS_DMA && !ARCH_S5PV210

Hmm, does this change really do the intended thing?

Since both S5PV210 and Exynos are multiplatform-aware, now whenever
ARCH_S5PV210 is enabled, it isn't possible to enable
VIDEO_EXYNOS4_FIMC_IS, even though ARCH_EXYNOS can be enabled as well at
the same time.

Best regards,
Tomasz
