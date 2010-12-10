From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Dec 2010 10:52:03 +0900
Subject: [PATCH] ARM S3C24XX: Fix compilation of PM code for S3C2416
In-Reply-To: <1291036180-8274-1-git-send-email-jekhor@gmail.com>
References: <1291036180-8274-1-git-send-email-jekhor@gmail.com>
Message-ID: <026501cb980c$dac38fb0$904aaf10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> S3C2416 PM code uses low-level sleep routines from S3C2412 code,
> but these routines are compiled only for S3C2412 SoC.
> 
> Split S3C2412_PM to two parts: S3C2412_PM, S3C2412_PM_SLEEP and
> select last in S3C2416's Kconfig.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2412/Kconfig  |    7 +++++++
>  arch/arm/mach-s3c2412/Makefile |    3 ++-
>  arch/arm/mach-s3c2416/Kconfig  |    1 +
>  3 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
> index fa2e5bf..6983cb4 100644
> --- a/arch/arm/mach-s3c2412/Kconfig
> +++ b/arch/arm/mach-s3c2412/Kconfig
> @@ -28,9 +28,16 @@ config S3C2412_DMA
> 
>  config S3C2412_PM
>  	bool
> +	select S3C2412_PM_SLEEP
>  	help
>  	  Internal config node to apply S3C2412 power management
> 
> +config S3C2412_PM_SLEEP
> +	bool
> +	help
> +	  Internal config node to apply sleep for S3C2412 power management.
> +	  Can be selected by another SoCs with similar sleep procedure.
> +
>  # Note, the S3C2412 IOtiming support is in plat-s3c24xx
> 
>  config S3C2412_CPUFREQ
> diff --git a/arch/arm/mach-s3c2412/Makefile
b/arch/arm/mach-s3c2412/Makefile
> index 530ec46..6c48a91 100644
> --- a/arch/arm/mach-s3c2412/Makefile
> +++ b/arch/arm/mach-s3c2412/Makefile
> @@ -14,7 +14,8 @@ obj-$(CONFIG_CPU_S3C2412)	+= irq.o
>  obj-$(CONFIG_CPU_S3C2412)	+= clock.o
>  obj-$(CONFIG_CPU_S3C2412)	+= gpio.o
>  obj-$(CONFIG_S3C2412_DMA)	+= dma.o
> -obj-$(CONFIG_S3C2412_PM)	+= pm.o sleep.o
> +obj-$(CONFIG_S3C2412_PM)	+= pm.o
> +obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep.o
>  obj-$(CONFIG_S3C2412_CPUFREQ)	+= cpu-freq.o
> 
>  # Machine support
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index 2eaadcf..69b48a7 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -27,6 +27,7 @@ config S3C2416_DMA
> 
>  config S3C2416_PM
>  	bool
> +	select S3C2412_PM_SLEEP
>  	help
>  	  Internal config node to apply S3C2416 power management
> 
> --
> 1.7.2.3

Hi,

Yeah, ok...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
