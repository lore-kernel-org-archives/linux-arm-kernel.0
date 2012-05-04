From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 04 May 2012 22:27:45 +0100
Subject: [PATCH 01/15] i2c/busses: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <201205042002.20943.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-2-git-send-email-lee.jones@linaro.org>
 <201205042002.20943.arnd@arndb.de>
Message-ID: <4FA449D1.1040106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/12 21:02, Arnd Bergmann wrote:
> On Friday 04 May 2012, Lee Jones wrote:
>> +static const struct nmk_i2c_controller *
>> +nmk_i2c_find_pdata_from_compatible(struct device_node *np)
>> +{
>> +       /*
>> +        * The u8500 is currently our only user. As more SoCs are added,
>> +        * search for the correct value set using of_machine_is_compatible
>> +        * and return a 'struct nmk_i2c_controller *' which contains the
>> +        * correct information for the given SoC, whilst leaving u8500_i2c
>> +        * as the default/fall-back value set.
>> +        */
>> +       return&u8500_i2c;
>> +}
>
> Why not just put this pointer ...
>
>> +static const struct of_device_id nmk_gpio_match[] = {
>> +       { .compatible = "st,nomadik-i2c", },
>> +       {}
>> +};
>
> into the .data field after the .compatible match, and make it more specific
> to the soc, i.e.
>
> static const struct of_device_id nmk_gpio_match[] = {
> 	{ .compatible = "st-ericsson,u8500-i2c", .data =&u8500_i2c },
> 	{ .compatible = "st,nomadik-i2c", .data =&default_i2c_controller },
> };

Because;
a) I only learned about .data way after this patch was written
and
b) _You_ told me to do it like this. ;)


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
