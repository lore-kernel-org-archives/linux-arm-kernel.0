From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 18 Nov 2015 08:24:00 -0800
Subject: [PATCH] watchdog: mtk_wdt: Use MODE_KEY when stopping the watchdog
In-Reply-To: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
References: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
Message-ID: <564CA620.7080700@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 06:45 PM, Nicolas Boichat wrote:
> WDT_MODE value need to be or-ed with MODE_KEY when setting
> watchdog mode. Add it to mtk_wdt_stop function, so that the
> watchdog can be stopped (e.g. during suspend).
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 6ad9df9..b751f43 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -123,6 +123,7 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
>
>   	reg = readl(wdt_base + WDT_MODE);
>   	reg &= ~WDT_MODE_EN;
> +	reg |= WDT_MODE_KEY;
>   	iowrite32(reg, wdt_base + WDT_MODE);
>
>   	return 0;
>
