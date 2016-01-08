From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jan 2016 16:02:45 +0900
Subject: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63E5A3E@penmbx01>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
 <CAJKOXPdzYJP_9DZUTz3EXPu4Z-DwkzYOJKEiR8varKJP3RRymw@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63E5A3E@penmbx01>
Message-ID: <568F5F15.8050602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.01.2016 15:43, Yang, Wenyou wrote:

[...]

>>> +static struct platform_driver act8945a_charger_driver = {
>>> +       .driver = {
>>> +               .name = "act8945a-charger",
>>> +       },
>>> +       .probe  = act8945a_charger_probe,
>>> +       .remove = act8945a_charger_remove, };
>>> +
>>> +static int __init act8945a_charger_init(void) {
>>> +       return platform_driver_register(&act8945a_charger_driver);
>>> +}
>>> +subsys_initcall(act8945a_charger_init);
>>
>> Why subsys_initcall? This should be regular module_platform_driver.
> 
> I want it to register early enough as MFD.  Maybe I am wrong.

No, you shouldn't manually order the probing by initcalls. This should
be registered as usual and, if needed, support deferred probing. In this
case I even can't find any reason to register it earlier than usual.


Best regards,
Krzysztof
