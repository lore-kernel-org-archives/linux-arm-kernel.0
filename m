From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 23 Feb 2015 10:25:26 +0000
Subject: [STLinux Kernel] [PATCH v3 5/8] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
In-Reply-To: <1424260154-12868-6-git-send-email-lee.jones@linaro.org>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20150223102526.GB14142@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

<snip>

> +#ifdef CONFIG_PM_SLEEP
> +static int st_wdog_suspend(struct device *dev)
> +{
> +	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
> +
> +	if (watchdog_active(&st_wdog_dev))
> +		st_wdog_stop(&st_wdog_dev);
> +
> +	st_wdog_setup(st_wdog, false);

I was expecting the suspend / resume callbacks would be disabling / enabling
the IP clock.

Is there a reason why it doesn't?

>From looking at the code by this point the watchdog has already been disabled so gating
the IP seems reasonable.

regards,

Peter
