From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 10 Feb 2018 19:54:09 -0800
Subject: [PATCH 1/4] watchdog: uniphier: change order for setting default
 timeout
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Message-ID: <2427b67d-7d4f-e82f-a6bf-cb51a75a67dc@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2018 12:36 PM, Marcus Folkesson wrote:
> watchdog_init_timeout() will preserve wdd->timeout value if no parameter
> nor timeout-secs dt property is set.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/uniphier_wdt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..0e4f8d53ce3c 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -212,11 +212,10 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
>   	wdev->wdt_dev.ops = &uniphier_wdt_ops;
>   	wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
>   	wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
> +	wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
>   	wdev->wdt_dev.parent = dev;
>   
> -	if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
> -		wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
> -	}
> +	watchdog_init_timeout(&wdev->wdt_dev, timeout, dev);
>   	watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
>   	watchdog_stop_on_reboot(&wdev->wdt_dev);
>   
> 
