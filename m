From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Aug 2014 08:40:10 -0700
Subject: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <20140814095733.GG17027@pengutronix.de>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
 <53EC487E.2000602@roeck-us.net> <20140814095733.GG17027@pengutronix.de>
Message-ID: <53ECD85A.8050903@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2014 02:57 AM, Markus Pargmann wrote:

>>> +
>>> +static int da9063_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
>>> +	struct da9063_watchdog *wdt;
>>> +
>>> +	if (!da9063)
>>> +		return -EPROBE_DEFER;
>>
>> Can this ever happen ? Isn't this driver instantiated from its parent,
>> which would ensure that the parent's driver data is set ?
>
> No this can't happen. I replaced it with BUG_ON and also introduced a
> BUG_ON check for dev.parent.
>
That is a bit too much. You should only use BUG_ON if the kernel can not
continue to run, which should not be the case here. I would suggest
to return -ENODEV.

Guenter
