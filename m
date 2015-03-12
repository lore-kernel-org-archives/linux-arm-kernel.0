From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 12 Mar 2015 03:41:45 -0700
Subject: [PATCH] pinctrl: mediatek: mt8135/mt8173: Fix build error due
 to missing include file
In-Reply-To: <CABuKBeKB=ghwRGOzUrxZ_46Joe9u883wOWoVrOeZ7EaX7C+--g@mail.gmail.com>
References: <1426143074.26140.0.camel@phoenix>
 <CABuKBeKB=ghwRGOzUrxZ_46Joe9u883wOWoVrOeZ7EaX7C+--g@mail.gmail.com>
Message-ID: <55016D69.8070802@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2015 03:32 AM, Matthias Brugger wrote:
> 2015-03-12 7:51 GMT+01:00 Axel Lin <axel.lin@ingics.com>:
>> Fix below build error:
>>    CC      drivers/pinctrl/mediatek/pinctrl-mt8135.o
>> In file included from drivers/pinctrl/mediatek/pinctrl-mt8135.c:24:0:
>> drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h:19:32: fatal error: pinctrl-mtk-common.h: No such file or directory
>> compilation terminated.
>> make[3]: *** [drivers/pinctrl/mediatek/pinctrl-mt8135.o] Error 1
>> make[2]: *** [drivers/pinctrl/mediatek] Error 2
>> make[1]: *** [drivers/pinctrl] Error 2
>> make: *** [drivers] Error 2
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> The fix from Guenter already addresses mt8135 case [0].
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> for the mt8173 part.
>

Axel's patch is more complete, so if my patch has not been applied yet
I would suggest to take this one instead.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Cheers,
> Matthias
>
> [0] https://lkml.org/lkml/2015/3/11/510
>
>> ---
>>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h | 2 +-
>>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
>> index 5019cef..e17aedb 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
>> @@ -16,7 +16,7 @@
>>   #define __PINCTRL_MTK_MT8135_H
>>
>>   #include <linux/pinctrl/pinctrl.h>
>> -#include <pinctrl-mtk-common.h>
>> +#include "pinctrl-mtk-common.h"
>>
>>   static const struct mtk_desc_pin mtk_pins_mt8135[] = {
>>          MTK_PIN(
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
>> index c1a3ca0..13e5b68 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
>> @@ -16,7 +16,7 @@
>>   #define __PINCTRL_MTK_MT8173_H
>>
>>   #include <linux/pinctrl/pinctrl.h>
>> -#include <pinctrl-mtk-common.h>
>> +#include "pinctrl-mtk-common.h"
>>
>>   static const struct mtk_desc_pin mtk_pins_mt8173[] = {
>>          MTK_PIN(
>> --
>> 1.9.1
>>
>>
>>
>
>
>
