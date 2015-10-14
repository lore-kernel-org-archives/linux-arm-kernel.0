From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 14 Oct 2015 10:27:49 +0200
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable Maxim 8997 family
 drivers
In-Reply-To: <561D04BB.1080406@samsung.com>
References: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
 <1444699628-3774-3-git-send-email-k.kozlowski@samsung.com>
 <CABxcv=m3tjo6rX3QVTjy3YPiM8AXF=m45TLVvc4-eZK+51X-8Q@mail.gmail.com>
 <561D04BB.1080406@samsung.com>
Message-ID: <561E1205.1040203@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/13/2015 03:18 PM, Krzysztof Kozlowski wrote:
> W dniu 13.10.2015 o 17:36, Javier Martinez Canillas pisze:
>> Hello Krzysztof,
>>
>> On Tue, Oct 13, 2015 at 3:27 AM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> Enable support for Maxim 8997 Multi Function Device present on Trats and
>>> Origen boards by toggling on drivers: main MFD, charger, haptic motor,
>>> regulator, LED and RTC.
>>>
>>> This allows to test and usage of these boards with multi_v7 config.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>
>> [snip]
>>
>>>  CONFIG_MFD_MAX77686=y
>>>  CONFIG_MFD_MAX77693=y
>>>  CONFIG_MFD_MAX8907=y
>>> +CONFIG_MFD_MAX8997=y
>>
>> Only slightly related with your patch but some of the MFD driver for
>> PMICs used in Exynos boards (like MAX77686) have a tristate Kconfig
>> symbol while others like this one have a boolean. Do you know if there
>> are any restrictions w.r.t build this as module or is just an
>> arbitrary decision? I'm asking since probably we should either allow
>> this to build as a module or convert the others to boolean.
> 
> First, thanks for reviewing the patches.
>

You are welcome.
 
> As for the question, I wasn't involved in development of these older
> drivers for older boards. I don't know their internals. AFAIK there were
> no specific restrictions, except the usual:
> 
> 1. Not all other drivers using resources provided by these, took the
> reference to given resource (e.g. get regulator).
> 
> 2. Not all consumer drivers supported deferred probe for given resource
> (e.g. regulator, clock), see: "regulators: max77693: register driver
> earlier to avoid deferred probe". In general USB gadget subsystem has
> this issue. Actually the mentioned max77693 regulator driver should be
> changed from tristate to built-in because of this.
> 
> I don't remember any other important issues so if you fix 1 and 2 then
> this can be probably safely switched to modules. Of course after testing.
>

Thanks for the explanation. I neither plan to fix these issues nor changing
these symbols to tristate since I don't have access to the hardware to test.

I asked mostly because I was curious and to know if I should change the MFD
drivers to boolean for the PMIC present in boards I have access, to make it
consistent. But as you said is the other way around, that it would be good
to allow these drivers to be built as a module.
 
> Best regards,
> Krzysztof
> 
> --

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
