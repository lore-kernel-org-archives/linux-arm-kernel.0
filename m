From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 26 Jul 2013 23:30:01 +0200
Subject: [PATCH v11] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51F2E4A7.1040200@codethink.co.uk>
References: <1374834384-8071-1-git-send-email-p.zabel@pengutronix.de>
 <51F2E4A7.1040200@codethink.co.uk>
Message-ID: <51F2EA59.8010908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 11:05 PM, Ben Dooks wrote:
> On 26/07/13 11:26, Philipp Zabel wrote:
>> This driver implements a reset controller device that toggle a gpio
>> connected to a reset pin of a peripheral IC. The delay between assertion
>> and de-assertion of the reset signal can be configured via device tree.
>>
>> Signed-off-by: Philipp Zabel<p.zabel@pengutronix.de>
>> Reviewed-by: Stephen Warren<swarren@nvidia.com>
>
> [snip]
>
>> +static struct of_device_id gpio_reset_dt_ids[] = {
>> + { .compatible = "gpio-reset" },
>> + { }
>> +};
>
> I think you need the following:
> MODULE_DEVICE_TABLE(of, gpio_reset_dt_ids);

It's already there, at bottom of the file. But if I'm not mistaken
the common practice is to keep it together with the actual array
definition. At least that's the case with, e.g. EXPORT_SYMBOL*.

>> +static struct platform_driver gpio_reset_driver = {
>> + .probe = gpio_reset_probe,
>> + .remove = gpio_reset_remove,
>> + .driver = {
>> + .name = "gpio-reset",
>> + .owner = THIS_MODULE,
>> + .of_match_table = of_match_ptr(gpio_reset_dt_ids),
>> + },
>> +};
>> +
>> +module_platform_driver(gpio_reset_driver);
>> +
>> +MODULE_AUTHOR("Philipp Zabel<p.zabel@pengutronix.de>");
>> +MODULE_DESCRIPTION("gpio reset controller");

nit: shouldn't gpio be capitalized ?

>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:gpio-reset");
>> +MODULE_DEVICE_TABLE(of, gpio_reset_dt_ids);

--
Regards,
Sylwester
