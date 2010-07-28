From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Jul 2010 13:24:31 +0900
Subject: [PATCH] Fix build error for mach-s3c64xx
In-Reply-To: <20100727195505.786.25117.stgit@darius-desktop>
References: <20100727195505.786.25117.stgit@darius-desktop>
Message-ID: <007801cb2e0c$ca3a8870$5eaf9950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> If SAMSUNG_DEV_ADC is not set, s3c6410_map_io()
> tries to init undefined device s3c_device_adc.
> ---
>  arch/arm/mach-s3c64xx/s3c6410.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/s3c6410.c
b/arch/arm/mach-s3c64xx/s3c6410.c
> index 014401c..29338bd 100644
> --- a/arch/arm/mach-s3c64xx/s3c6410.c
> +++ b/arch/arm/mach-s3c64xx/s3c6410.c
> @@ -54,7 +54,10 @@ void __init s3c6410_map_io(void)
>  	s3c_i2c0_setname("s3c2440-i2c");
>  	s3c_i2c1_setname("s3c2440-i2c");
> 
> +#ifdef CONFIG_SAMSUNG_DEV_ADC
>  	s3c_device_adc.name	= "s3c64xx-adc";
> +#endif
> +
>  	s3c_device_nand.name = "s3c6400-nand";
>  	s3c_onenand_setname("s3c6410-onenand");
>  	s3c64xx_onenand1_setname("s3c6410-onenand");
> 
> 

Hi,

Already submitted and applied about this.

Please refer to below URL.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/019225.html

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019436.html

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
