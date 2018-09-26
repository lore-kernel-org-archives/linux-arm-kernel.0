From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Wed, 26 Sep 2018 16:44:23 +0300
Subject: [PATCH] ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency
In-Reply-To: <20180926125957.2256982-1-arnd@arndb.de>
References: <20180926125957.2256982-1-arnd@arndb.de>
Message-ID: <f0410312-de2b-d0a8-4236-d7a751712767@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.09.2018 15:59, Arnd Bergmann wrote:
> Selecting SND_SOC_WM8731 is only allowed when all its dependencies
> are already there:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WM8731
>    Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=m]
>    Selected by [y]:
>    - SND_SOC_MIKROE_PROTO [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && OF [=y]
>    Selected by [m]:
>    - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && (ARCH_AT91 [=y] || COMPILE_TEST [=y]) && ATMEL_SSC [=y] && SND_SOC_I2C_AND_SPI [=m]
>    - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMPILE_TEST [=y] && SND_SOC_I2C_AND_SPI [=m]
> 
> Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thank you!

Best regards,
Codrin

> ---
>   sound/soc/atmel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 81a0712d4f14..64f86f0b87e5 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -101,6 +101,7 @@ config SND_ATMEL_SOC_I2S
>   config SND_SOC_MIKROE_PROTO
>   	tristate "Support for Mikroe-PROTO board"
>   	depends on OF
> +	depends on SND_SOC_I2C_AND_SPI
>   	select SND_SOC_WM8731
>   	help
>   	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
> 
