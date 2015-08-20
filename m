From: Adam.Thomson.Opensource@diasemi.com (Opensource [Adam Thomson])
Date: Thu, 20 Aug 2015 08:30:35 +0000
Subject: [PATCH V3] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB56C694@SW-EX-MBX01.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 19, 2015 04:28, Pratyush Anand wrote:

> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index 2e9589652e1e..67e67977bd29 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -195,6 +195,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
>  	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
>  	da9052_wdt->info = &da9052_wdt_info;
>  	da9052_wdt->ops = &da9052_wdt_ops;
> +	da9052_wdt->parent = &pdev->dev;
>  	watchdog_set_drvdata(da9052_wdt, driver_data);
> 
>  	kref_init(&driver_data->kref);
> diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
> index 495089d8dbfe..04d1430d93d2 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -161,6 +161,7 @@ static int da9055_wdt_probe(struct platform_device *pdev)
>  	da9055_wdt->timeout = DA9055_DEF_TIMEOUT;
>  	da9055_wdt->info = &da9055_wdt_info;
>  	da9055_wdt->ops = &da9055_wdt_ops;
> +	da9055_wdt->parent = &pdev->dev;
>  	watchdog_set_nowayout(da9055_wdt, nowayout);
>  	watchdog_set_drvdata(da9055_wdt, driver_data);
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index b3a870ce85be..7386111220d5 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -210,6 +210,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
>  	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
>  	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +	wdt->wdtdev.parent = &pdev->dev;
> 
>  	watchdog_set_drvdata(&wdt->wdtdev, wdt);
>  	dev_set_drvdata(&pdev->dev, wdt);
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index e2fe2ebdebd4..6bf130bd863d 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -175,6 +175,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>  	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
>  	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
>  	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
> +	wdt->wdtdev.parent = &pdev->dev;
> 
>  	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> 

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
