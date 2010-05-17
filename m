From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 20:14:25 +0900
Subject: [PATCH 04/15] drivers: serial: S5PC100 serial driver cleanup
In-Reply-To: <1273817946-29404-5-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <003101caf5b2$200df590$6029e0b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Remove unnecessary Kconfig entry. S5PC100 has exactly the same driver as
> S3C6400/S3C6410/S5P6440.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/serial/Kconfig  |   16 ++++------------
>  drivers/serial/Makefile |    1 -
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 5f3f03d..302836a 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -534,21 +534,13 @@ config SERIAL_S3C24A0
>  	  Serial port support for the Samsung S3C24A0 SoC
> 
>  config SERIAL_S3C6400
> -	tristate "Samsung S3C6400/S3C6410/S5P6440 Seria port support"
> -	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 ||
> CPU_S5P6440)
> +	tristate "Samsung S3C6400/S3C6410/S5P6440/S5PC100 Serial port
> support"
> +	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 ||
> CPU_S5P6440 || CPU_S5PC100)
>  	select SERIAL_SAMSUNG_UARTS_4
>  	default y
>  	help
> -	  Serial port support for the Samsung S3C6400, S3C6410 and S5P6440
> -	  SoCs
> -
> -config SERIAL_S5PC100
> -	tristate "Samsung S5PC100 Serial port support"
> -	depends on SERIAL_SAMSUNG && CPU_S5PC100
> -	select SERIAL_SAMSUNG_UARTS_4
> -	default y
> -	help
> -	  Serial port support for the Samsung S5PC100 SoCs
> +	  Serial port support for the Samsung S3C6400, S3C6410, S5P6440
> +	  and S5PC100 SoCs
> 
>  config SERIAL_S5PV210
>  	tristate "Samsung S5PV210 Serial port support"
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

Ok, updated the list of supported devices.

Looks good.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
