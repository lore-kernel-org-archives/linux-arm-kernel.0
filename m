From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jan 2014 09:31:25 +0100
Subject: [PATCH v5 3/4] [media] exynos-scaler: Add m2m functionality for
 the SCALER driver
In-Reply-To: <1389238094-19386-4-git-send-email-shaik.ameer@samsung.com>
References: <1389238094-19386-1-git-send-email-shaik.ameer@samsung.com>
 <1389238094-19386-4-git-send-email-shaik.ameer@samsung.com>
Message-ID: <2693737.HeuDsQMSy5@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, January 09, 2014 08:58:13 AM Shaik Ameer Basha wrote:
> This patch adds the Makefile and memory to memory (m2m) interface
> functionality for the SCALER driver.
> 
> [arun.kk at samsung.com: fix compilation issues]
> 
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/media/platform/Kconfig                    |    8 +
>  drivers/media/platform/Makefile                   |    1 +
>  drivers/media/platform/exynos-scaler/Makefile     |    3 +
>  drivers/media/platform/exynos-scaler/scaler-m2m.c |  788 +++++++++++++++++++++

It would be cleaner to add Kconfig + Makefiles in the same patch
that adds core functionality (patch #2) and then switch the order of
patch #2 and patch #3.

>  4 files changed, 800 insertions(+)
>  create mode 100644 drivers/media/platform/exynos-scaler/Makefile
>  create mode 100644 drivers/media/platform/exynos-scaler/scaler-m2m.c
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index b2a4403..aec5b80 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -196,6 +196,14 @@ config VIDEO_SAMSUNG_EXYNOS_GSC
>  	help
>  	  This is a v4l2 driver for Samsung EXYNOS5 SoC G-Scaler.
>  
> +config VIDEO_SAMSUNG_EXYNOS_SCALER
> +	tristate "Samsung Exynos SCALER driver"
> +	depends on OF && VIDEO_DEV && VIDEO_V4L2 && ARCH_EXYNOS5

Please check for EXYNOS5410 and EXYNOS5420 explicitly instead
of checking just for ARCH_EXYNOS5.

Also this config option doesn't need to depend on OF since
the whole EXYNOS support is OF only now.

> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	  This is a v4l2 driver for Samsung EXYNOS5410/5420 SoC SCALER.
> +
>  config VIDEO_SH_VEU
>  	tristate "SuperH VEU mem2mem video processing driver"
>  	depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
