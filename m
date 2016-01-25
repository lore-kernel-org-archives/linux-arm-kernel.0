From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 25 Jan 2016 08:41:52 -0800
Subject: [PATCH] watchdog: imgdpc: select WATCHDOG_CORE
In-Reply-To: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
References: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
Message-ID: <56A65050.5010708@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016 08:06 AM, Arnd Bergmann wrote:
> The imgpdc_wdt driver can be built on all architectures with
> CONFIG_COMPILE_TEST, but fails if no other watchdog driver is
> enabled:
>
> drivers/watchdog/built-in.o: In function `pdc_wdt_remove':
> imgpdc_wdt.c:(.text+0x74): undefined reference to `watchdog_unregister_device'
>
> This adds the normal 'select WATCHDOG_CORE' that is needed to
> ensure the driver always builds cleanly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..0dc61f1a552e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1383,6 +1383,7 @@ config IMGPDC_WDT
>   	tristate "Imagination Technologies PDC Watchdog Timer"
>   	depends on HAS_IOMEM
>   	depends on METAG || MIPS || COMPILE_TEST
> +	select WATCHDOG_CORE
>   	help
>   	  Driver for Imagination Technologies PowerDown Controller
>   	  Watchdog Timer.
>
