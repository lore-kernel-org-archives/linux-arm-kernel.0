From: ajaynumb@gmail.com (Ajay kumar)
Date: Thu, 31 Jul 2014 15:31:04 +0530
Subject: [PATCH v3 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA1231.70309@suse.de>
References: <1406728244-5105-1-git-send-email-afaerber@suse.de>
 <1406728244-5105-5-git-send-email-afaerber@suse.de>
 <53DA0BAA.8090000@suse.de>
 <CAEC9eQNuPN+WiKGOtCosCwcR48MNawQL7dU4S8=dbA4eFXB_-w@mail.gmail.com>
 <53DA1231.70309@suse.de>
Message-ID: <CAEC9eQOfeW==+YhWbYT5zbCYtQ+poe5=NL2bcuL4GOjPrpQ5hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 3:23 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 31.07.2014 11:49, schrieb Ajay kumar:
>> On Thu, Jul 31, 2014 at 2:56 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> Am 30.07.2014 15:50, schrieb Andreas F?rber:
>>>> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
>>>> new file mode 100644
>>>> index 000000000000..bcca892bf2ff
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
>>> [...]
>>>> +&pinctrl_0 {
>>>> +     dp_hpd_gpio: dp-hpd-gpio {
>>>> +             samsung,pins = "gpc3-0";
>>>> +             samsung,pin-function = <1>;
>>>
>>> Not sure where this 1 came from... Both Ajay and my 3.8 DT have 0.
>> Right, this should be 0.
>>
>>>> +             samsung,pin-pud = <3>;
>>>> +             samsung,pin-drv = <0>;
>>>> +     };
>>>
>>> Seeing that Ajay called this node dp-hdp, it should probably be an override?
>> dp_hpd should be enough. I will keep the same name for peach boards.
>> dp_hpd: dp-hpd {
>> .
>> .
>> .
>> };
>
> Apart from my own set of typos, I see that you proposed dp-hpd whereas
> -pinctrl.dtsi has dp_hpd (dash vs. underscore). My question is, can we
> override the pinctrl one instead of adding a new one, or do they need to
> coexist?
The one in exynos5250-pinctrl.dtsi will be used only for smdk5250/snow.
For spring, you can override the same.

Ajay
