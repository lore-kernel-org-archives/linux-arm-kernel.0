From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 12:48:28 +0900
Subject: [PATCH 45/62] ARM: s3c24xx: MINI2440 needs I2C for EEPROM_AT24
In-Reply-To: <1395257399-359545-46-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-46-git-send-email-arnd@arndb.de>
Message-ID: <01dd01cf43ef$415d44f0$c417ced0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> If I2C is disabled, we cannot build the AT24 driver, so we
> should not select it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index bb1fa603..a6060d0 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -536,7 +536,7 @@ config MACH_AT2440EVB
> 
>  config MACH_MINI2440
>  	bool "MINI2440 development board"
> -	select EEPROM_AT24
> +	select EEPROM_AT24 if I2C
>  	select LEDS_CLASS
>  	select LEDS_TRIGGERS
>  	select LEDS_TRIGGER_BACKLIGHT
> --
> 1.8.3.2
