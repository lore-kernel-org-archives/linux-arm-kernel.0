From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 Jan 2016 16:53:04 +0900
Subject: [PATCH v5 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <569F3C45.7090109@atmel.com>
References: <1452747845-2962-1-git-send-email-wenyou.yang@atmel.com>
 <1452747845-2962-2-git-send-email-wenyou.yang@atmel.com>
 <87pox41dy9.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63ECA51@penmbx01>
 <8737tzz33h.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63F61F4@penmbx01>
 <87d1swvgv8.fsf@dell.be.48ers.dk> <569F3C45.7090109@atmel.com>
Message-ID: <569F3CE0.6020107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.01.2016 16:50, Yang, Wenyou wrote:
> Hi Peter,
> 
> On 2016/1/20 15:40, Peter Korsgaard wrote:
>>>>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:
>> Hi,
>>
>>>> But the charger driver can just as well do:
>>   >>
>>   >> dev_get_regmap(dev->parent);
>>   >>
>>   >> instead of:
>>   >>
>>   >> dev_get_drvdata(pdev->dev.parent)->regmap.
>>
>>   > For regulator, it works use the core do dev_get_regmap(dev->parent),
>>   > but for charger, it need to export *act8945a.
>>
>> Why?
> 
> There is a callback (*get_property)(...), who will read the charger
> register via regmap,
> 
> but it doesn't provide the argument for regmap.
> 
> include/linux/power_supply.h
> 
> struct power_supply_desc {
>         [ ... ]
>         int (*get_property)(struct power_supply *psy,
>                              enum power_supply_property psp,
>                              union power_supply_propval *val);
>         [ ... ]
> 
> }
> 
>>
>> Just like the regulator core does, your battery driver can do:
>>
>> dev_get_regmap(dev->parent);
>>

Why can't you store the pointer to regmap as power supply driver data?
There is really no need for the structure containing only one pointer.

BR,
Krzysztof
