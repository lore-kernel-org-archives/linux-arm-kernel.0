From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Jan 2016 09:21:44 +0900
Subject: [PATCH] ARM: s3c64xx: Select GPIO_GENERIC_PLATFORM for Cragganmore
In-Reply-To: <1453400718-26720-1-git-send-email-broonie@kernel.org>
References: <1453400718-26720-1-git-send-email-broonie@kernel.org>
Message-ID: <56A17618.4030008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.01.2016 03:25, Mark Brown wrote:
> The Cragganmore machine driver provides platform data for the generic GPIO
> platform driver which uses structures only defined if the driver is
> enabled. Since there is little reason to use the platform without the GPIOs
> add a select to avoid build failures.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm/mach-s3c64xx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 7c0c420c3016..98d2aa9393f1 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -310,6 +310,7 @@ config MACH_WLF_CRAGG_6410
>  	depends on I2C=y
>  	select CPU_S3C6410
>  	select LEDS_GPIO_REGISTER
> +	select GPIO_GENERIC_PLATFORM
>  	select S3C64XX_DEV_SPI0
>  	select S3C64XX_SETUP_FB_24BPP
>  	select S3C64XX_SETUP_I2C1
> 


Thanks for the patch!
This was already fixed by Arnd:
http://marc.info/?l=linux-gpio&m=145237423205247&w=2

Best regards,
Krzysztof
