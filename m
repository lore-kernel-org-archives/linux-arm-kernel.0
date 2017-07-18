From: j-keerthy@ti.com (Keerthy)
Date: Tue, 18 Jul 2017 23:18:41 +0530
Subject: [PATCH 3/4] gpio: davinci: Add a separate compatible for
 keystone-k2g soc
In-Reply-To: <902db353-2db1-fa86-5f96-541082348a35@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-4-git-send-email-j-keerthy@ti.com>
 <902db353-2db1-fa86-5f96-541082348a35@ti.com>
Message-ID: <8551db79-611e-e8f3-3756-ef4930760924@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 July 2017 05:01 PM, Sekhar Nori wrote:
> Hi Keerthy,
> 
> On Tuesday 18 July 2017 04:27 PM, Keerthy wrote:
>> Add a separate compatible for keystone-k2g soc
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  Documentation/devicetree/bindings/gpio/gpio-davinci.txt | 3 ++-
>>  drivers/gpio/gpio-davinci.c                             | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> index 5079ba7..1a5c1a2 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> @@ -1,7 +1,8 @@
>>  Davinci/Keystone GPIO controller bindings
>>  
>>  Required Properties:
>> -- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
>> +- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio",
>> +	      "ti,keystone-k2g-gpio"
>>  
>>  - reg: Physical base address of the controller and the size of memory mapped
>>         registers.
>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>> index 932f270..a8d8dd9 100644
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -610,6 +610,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>>  static const struct of_device_id davinci_gpio_ids[] = {
>>  	{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
>>  	{ .compatible = "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
>> +	{ .compatible = "ti,keystone-k2g-gpio", keystone_gpio_get_irq_chip},
> 
> You don't have to add compatible matching to the driver if you don't
> need any special handling for K2G ATM. Your dts should have:
> 
> compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
> 
> this way, the driver continues to probe using "ti,keystone-gpio", and
> when you really discover a need to do some special handling for K2G, a
> kernel update will do without the need for a DT update.

Sure that is better to do as currently i do not see any differences
between k2g and other k2 devices.

> 
> Thanks,
> Sekhar
> 
