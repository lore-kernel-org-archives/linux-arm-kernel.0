From: oliver@schinagl.nl (Olliver Schinagl)
Date: Wed, 07 Jan 2015 10:26:18 +0100
Subject: [PATCH v1] ARM:sunxi:sid: Make use of the of_match_ptr
In-Reply-To: <12820267.9PZueKuf7O@wuerfel>
References: <1420616468-3782-1-git-send-email-oliver+list@schinagl.nl>
 <12820267.9PZueKuf7O@wuerfel>
Message-ID: <54ACFBBA.3020201@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Arnd,
On 07-01-15 10:00, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 08:41:08 Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> I probably have forgotten to use this macro for the of_match pointer, so
>> this patch adds the of_match_ptr macro.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   drivers/misc/eeprom/sunxi_sid.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/misc/eeprom/sunxi_sid.c
>> index 8385177..5a330d9 100644
>> --- a/drivers/misc/eeprom/sunxi_sid.c
>> +++ b/drivers/misc/eeprom/sunxi_sid.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/kobject.h>
>>   #include <linux/module.h>
>> +#include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/random.h>
>> @@ -146,7 +147,7 @@ static struct platform_driver sunxi_sid_driver = {
>>          .remove = sunxi_sid_remove,
>>          .driver = {
>>                  .name = DRV_NAME,
>> -               .of_match_table = sunxi_sid_of_match,
>> +               .of_match_table = of_match_ptr(sunxi_sid_of_match),
>>          },
>>   };
>>   module_platform_driver(sunxi_sid_driver);
> This looks wrong: sunxi_sid_of_match is defined unconditionally, so
> now you get a compiler warning if CONFIG_OF is disabled.
>
> The existing code is good, we only add the of_match_ptr() for drivers
> that are useful without CONFIG_OF and that want to save a few bytes
> in .data size.
Ah, I missunderstood its use then!It looked like the of_match_ptr() got 
defined away otherwise. Sorry for the noise!

Olliver
>
> 	Arnd
