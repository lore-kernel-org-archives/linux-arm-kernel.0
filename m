From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 6 Apr 2010 16:59:51 +0100
Subject: [PATCH 02/16] drivers: serial: S5PC100 serial driver cleanup
In-Reply-To: <1270190944-21644-3-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100406155951.GS31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 08:48:50AM +0200, Marek Szyprowski wrote:
> Remove unnecessary Kconfig entry. S5PC100 has exactly the same driver as
> S3C6400/S3C6410/S5P6440.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/serial/Kconfig  |   10 +---------
>  drivers/serial/Makefile |    1 -
>  2 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index f55c494..b68ea18 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -534,21 +534,13 @@ config SERIAL_S3C24A0
>  
>  config SERIAL_S3C6400
>  	tristate "Samsung S3C6400/S3C6410/S5P6440 Seria port support"

it would have been nice to update the list of supported devices above.

> -	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440)
> +	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440 || CPU_S5PC100)
>  	select SERIAL_SAMSUNG_UARTS_4
>  	default y
>  	help
>  	  Serial port support for the Samsung S3C6400, S3C6410 and S5P6440
>  	  SoCs
>  
> -config SERIAL_S5PC100
> -	tristate "Samsung S5PC100 Serial port support"
> -	depends on SERIAL_SAMSUNG && CPU_S5PC100
> -	select SERIAL_SAMSUNG_UARTS_4
> -	default y
> -	help
> -	  Serial port support for the Samsung S5PC100 SoCs
> -
>  config SERIAL_S5PV210
>  	tristate "Samsung S5PV210 Serial port support"
>  	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442)
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 6aa4723..328f107 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -44,7 +44,6 @@ obj-$(CONFIG_SERIAL_S3C2412) += s3c2412.o
>  obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
>  obj-$(CONFIG_SERIAL_S3C24A0) += s3c24a0.o
>  obj-$(CONFIG_SERIAL_S3C6400) += s3c6400.o
> -obj-$(CONFIG_SERIAL_S5PC100) += s3c6400.o
>  obj-$(CONFIG_SERIAL_S5PV210) += s5pv210.o
>  obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
>  obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
> -- 
> 1.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
