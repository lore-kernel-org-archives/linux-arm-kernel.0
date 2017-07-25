From: j-keerthy@ti.com (Keerthy)
Date: Tue, 25 Jul 2017 08:52:53 +0530
Subject: [PATCH 3/4] gpio: davinci: Add a separate compatible for
 keystone-k2g soc
In-Reply-To: <20170724182427.64u5zmr2jl3hk5lh@rob-hp-laptop>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-4-git-send-email-j-keerthy@ti.com>
 <20170724182427.64u5zmr2jl3hk5lh@rob-hp-laptop>
Message-ID: <decf6160-621a-8d73-8694-e5091ea50d27@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 24 July 2017 11:54 PM, Rob Herring wrote:
> On Tue, Jul 18, 2017 at 04:27:15PM +0530, Keerthy wrote:
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
> 
> Reformat to one valid combination per line.

Sure Rob. Thanks for reviewing.

> 
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
>>  	{ /* sentinel */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, davinci_gpio_ids);
>> -- 
>> 1.9.1
>>
