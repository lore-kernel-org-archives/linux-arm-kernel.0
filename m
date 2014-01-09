From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 8 Jan 2014 16:54:19 -0800
Subject: [RESEND PATCH] ARM: dts: bcm28155-ap: Fix Card Detection GPIO
In-Reply-To: <CAAYSxhpgJwnq63fUdYBtmneRads_69c2mik8upofvAS1Y25fOA@mail.gmail.com>
References: <1389120821-12007-1-git-send-email-tim.kryger@linaro.org>
 <CAEPRUYo0r5YcRTYdgSNLqedVV4D0bsor7USBoxRRpBXRs7wpbw@mail.gmail.com>
 <CAAYSxhpgJwnq63fUdYBtmneRads_69c2mik8upofvAS1Y25fOA@mail.gmail.com>
Message-ID: <CAEPRUYpyr2_3pfa3rqYiYPAOwJfA+0AdqyGaf5s7YiWH=zfTeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 4:28 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Wed, Jan 8, 2014 at 3:38 PM, Christian Daudt <bcm@fixthebug.org> wrote:
>> On Tue, Jan 7, 2014 at 10:53 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
>>> The board schematic states that the "SD_CARD_DET_N gets pulled to GND
>>> when card is inserted" so the polarity has been updated to active low.
>>>
>>> Polarity is now specified with a GPIO define instead of a magic number.
>>>
>>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/bcm28155-ap.dts | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
>>> index 08e47c2..27dd110 100644
>>> --- a/arch/arm/boot/dts/bcm28155-ap.dts
>>> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
>>> @@ -13,6 +13,8 @@
>>>
>>>  /dts-v1/;
>>>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>>  #include "bcm11351.dtsi"
>>>
>>>  / {
>>> @@ -40,7 +42,7 @@
>>>
>>>         sdio4: sdio at 3f1b0000 {
>>>                 max-frequency = <48000000>;
>>> -               cd-gpios = <&gpio 14 0>;
>>> +               cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
>>>                 status = "okay";
>>>         };
>>>  };
>>> --
>>> 1.8.0.1
>>>
>> Tim,
>>  Does bcm11351-brt not also suffer from the same bug? If it does can
>> you pls update the patch to also fix it?
>>
>>  Thanks,
>>    csd
>
> The BRT and AP boards are similar so it may have the same problem but
> I don't have a BRT and wouldn't be able to test any changes to its DTS
> file.
>
> -Tim

[sorry for the resend for those that get it twice]
Agreed - it's time that dts file go away. In this case:
Acked-by: Christian Daudt <bcm@fixthebug.org>

Olof - can you pls pull in this patch. This is the bugfix that was
discussed in irc earlier today.

 thanks,
   csd
