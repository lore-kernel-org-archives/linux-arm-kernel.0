From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Oct 2016 09:23:03 -0700
Subject: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
 (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 16:49:42
 -0300")
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
Message-ID: <7hd1iv7zx4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier@osg.samsung.com> writes:

> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
>
> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
> since the reported uevent MODALIAS to user-space will be the OF one.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
>  drivers/watchdog/meson_gxbb_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 44d180a2c5e5..45d47664a00a 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -264,7 +264,6 @@ static struct platform_driver meson_gxbb_wdt_driver = {
>  
>  module_platform_driver(meson_gxbb_wdt_driver);
>  
> -MODULE_ALIAS("platform:meson-gxbb-wdt");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>  MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
>  MODULE_LICENSE("Dual BSD/GPL");
