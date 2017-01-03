From: Adam.Thomson.Opensource@diasemi.com (Adam Thomson)
Date: Tue, 3 Jan 2017 13:51:54 +0000
Subject: [PATCH v2] watchdog: constify watchdog_info structures
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A7539F@SW-EX-MBX01.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 December 2016 17:05, Bhumika Goyal wrote:

> Declare watchdog_info structures as const as they are only stored in the
> info field of watchdog_device structures. This field is of type const
> struct watchdog_info *, so watchdog_info structures having this property
> can be declared const too.

> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index 2fc19a3..d86a57e 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -140,7 +140,7 @@ static int da9052_wdt_ping(struct watchdog_device
> *wdt_dev)
>  	return ret;
>  }
> 
> -static struct watchdog_info da9052_wdt_info = {
> +static const struct watchdog_info da9052_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	= "DA9052 Watchdog",
>  };
> diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
> index 8377c43..4f30818 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -108,7 +108,7 @@ static int da9055_wdt_stop(struct watchdog_device
> *wdt_dev)
>  	return da9055_wdt_set_timeout(wdt_dev, 0);
>  }
> 
> -static struct watchdog_info da9055_wdt_info = {
> +static const struct watchdog_info da9055_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	= "DA9055 Watchdog",
>  };

For DA9052 and DA9055:

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
