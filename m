From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 6 Nov 2014 09:49:10 +0100
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
Message-ID: <20141106084910.GA10432@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Nov 05, 2014 at 10:42:52PM +0100, Arnaud Ebalard wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static int isl12057_rtc_suspend(struct device *dev)
> +{
> +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
drivers/rtc/rtc-isl12057.c: In function 'isl12057_rtc_suspend':
drivers/rtc/rtc-isl12057.c:551:56: error: 'client' undeclared (first use in this function)

> +
> +	if (device_may_wakeup(dev))
> +		return enable_irq_wake(rtc_data->irq);
> +
> +	return 0;
>  }

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
