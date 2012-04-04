From: stigge@antcom.de (Roland Stigge)
Date: Wed, 04 Apr 2012 13:08:04 +0200
Subject: [PATCH v2] gpio: Device tree support for LPC32xx
In-Reply-To: <201204040848.39376.arnd@arndb.de>
References: <1333497518-25838-1-git-send-email-stigge@antcom.de>
 <201204040848.39376.arnd@arndb.de>
Message-ID: <4F7C2B94.8090601@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2012 10:48 AM, Arnd Bergmann wrote:
>> +#ifdef CONFIG_OF
>> +static struct of_device_id lpc32xx_gpio_of_match[] __devinitdata = {
>> +	{ .compatible = "nxp,lpc32xx-gpio", },
>> +	{ },
>> +};
>> +#endif
>> +
>> +static struct platform_driver lpc32xx_gpio_driver = {
>> +	.driver		= {
>> +		.name	= "lpc32xx-gpio",
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = lpc32xx_gpio_of_match,
>> +	},
>> +	.probe		= lpc32xx_gpio_probe,
>> +};
> 
> The #ifdef above is not helpful, it will cause a build error in the
> of_match_table= assignment. Since the plan for this driver is to
> be devicetree-only, it would be appropriate to just remove the
> #ifdef, but adding of_match_ptr() is ok too.

I think I just forgot the of_match_ptr(). Will post an update with a
repo for gpio to pull from.

Thanks for the note!

Roland
