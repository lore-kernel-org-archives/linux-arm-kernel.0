From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Tue, 26 Aug 2014 15:21:53 +0000
Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
In-Reply-To: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
References: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26 August 2014 07:26, Markus Pargmann wrote

> Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
> 

[...]

> +
> +static int da9063_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	mutex_lock(&wdt->lock);
> +	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> +			DA9063_TWDSCALE_MASK,
> +			DA9063_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err = %d)\n",
> +				ret);
> +	mutex_unlock(&wdt->lock);
> +
> +	return ret;
> +}
> +

Hi Markus,

A quick typo.
ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
should probably be wdt->da9063->regmap

Regards,
Steve
