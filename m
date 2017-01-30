From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Jan 2017 09:37:31 -0800
Subject: [PATCH V2] ARM: dts: BCM5301X: Add missing Netgear R8000 LEDs and
 Keys
In-Reply-To: <A0233283-B547-42E5-BBBF-3B75E592D858@gmail.com>
References: <20170128143749.5897-1-adityaxavier@gmail.com>
 <CACna6rzaEw+_tgMtG5ASRX+AZSbg-yA=pnpaD9uE1AK8ZGKJ1Q@mail.gmail.com>
 <A0233283-B547-42E5-BBBF-3B75E592D858@gmail.com>
Message-ID: <4f21b12f-b099-bf52-1fa2-0ef3d3ebf7e9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2017 01:08 AM, Aditya Xavier wrote:
> Would you require me to send the revised Patch ?
> 
> Or would this do ?

Will take care of it this time.

> 
> And thanks for guiding me through this process :)
> 
> 
>> On 29-Jan-2017, at 2:45 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>>
>> On 28 January 2017 at 15:37, AdityaXavier <adityaxavier@gmail.com> wrote:
>>> From: Aditya Xavier <adityaxavier@gmail.com>
>>>
>>> Added two WAN status LEDs and a GPIO Key for Brightness which were missing.
>>> V2: Updated subject, Power LED names, and WAN labels.
>>
>> Changelog (V2 ... part) should go into that /comments/ section (see below).
>> Florian: can you drop that line when applying this patch? Otherwise it
>> looks OK to me.
>>
>>
>>> Signed-off-by: Aditya Xavier <adityaxavier@gmail.com>
>>
>> Acked-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Thanks for the patch!
>>
>>
>>> ---
>>
>> Right here, below these 3 dashes is a place where you can add extra
>> comments (they won't go into log when doing "git am").
>>
>>> arch/arm/boot/dts/bcm4709-netgear-r8000.dts | 22 ++++++++++++++++++++--
>>> 1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
>>> index 92f8a72..90d4420 100644
>>> --- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
>>> +++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
>>> @@ -27,18 +27,30 @@
>>>        leds {
>>>                compatible = "gpio-leds";
>>>
>>> -               power0 {
>>> +               power-white {
>>>                        label = "bcm53xx:white:power";
>>>                        gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
>>>                        linux,default-trigger = "default-on";
>>>                };
>>>
>>> -               power1 {
>>> +               power-amber {
>>>                        label = "bcm53xx:amber:power";
>>>                        gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
>>>                        linux,default-trigger = "default-off";
>>>                };
>>>
>>> +               wan-white {
>>> +                       label = "bcm53xx:white:wan";
>>> +                       gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
>>> +                       linux,default-trigger = "default-on";
>>> +               };
>>> +
>>> +               wan-amber {
>>> +                       label = "bcm53xx:amber:wan";
>>> +                       gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
>>> +                       linux,default-trigger = "default-off";
>>> +               };
>>> +
>>>                5ghz-1 {
>>>                        label = "bcm53xx:white:5ghz-1";
>>>                        gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
>>> @@ -104,6 +116,12 @@
>>>                        linux,code = <KEY_RESTART>;
>>>                        gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
>>>                };
>>> +
>>> +               brightness {
>>> +                       label = "Backlight";
>>> +                       linux,code = <KEY_BRIGHTNESS_ZERO>;
>>> +                       gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
>>> +               };
>>>        };
>>> };
>>>
>>> --
>>> 2.9.3
>>>
>>
>>
>>
>> -- 
>> Rafa?
> 


-- 
Florian
