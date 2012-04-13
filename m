From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 16:16:28 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <1334329500.27644.18.camel@hornet>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <1334328122.27644.15.camel@hornet> <201204131451.10638.arnd@arndb.de>
 <4F883E40.6000905@linaro.org> <1334329500.27644.18.camel@hornet>
Message-ID: <4F88434C.9010709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/12 16:05, Pawel Moll wrote:
> On Fri, 2012-04-13 at 15:54 +0100, Lee Jones wrote:
>> On 13/04/12 15:51, Arnd Bergmann wrote:
>>> On Friday 13 April 2012, Pawel Moll wrote:
>>>> On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
>>>>> +     of_property_read_u32(np, "wp-gpios",&pdata->gpio_wp);
>>>>> +     if (!pdata->gpio_wp)
>>>>> +             pdata->gpio_wp = -1;
>>>>> +
>>>>> +     of_property_read_u32(np, "cd-gpios",&pdata->gpio_cd);
>>>>> +     if (!pdata->gpio_cd)
>>>>> +             pdata->gpio_cd = -1;
>>>>
>>>> I think you should use of_gpio_named_count(np, "XX-gpios") here rather
>>>> then of_property_read() - there's more to GPIOs than just a number...
>
> Of course I meant of_get_named_gpio(np, "XX-gpios", 0) not
> _named_count ;-)
>
>>> Hmm, that part was done right in the git tree, I guess something
>>> went wrong when sending out the series.
>>
>> Different patch series.
>>
>> The GPIO bindings aren't in yet. Once this one is accepted, I'll fire
>> off the second patch-set.
>
> Em, I'm not sure I'm following... Why not use the proper API
> immediately?
>
> Generally, except for that, looks good to me.

Because in it's current state, gpio-nomadik doesn't know how to decode 
any provided flags and phandles don't work yet, hence the IRQ request 
really is just a number in this case. In a latter patch-set I provide 
the GPIO driver with said bindings and swap the simple integer format 
for one which is more in keeping with the DT format e.g. <32> becomes 
<&gpio1 1 0x4> for instance.

This patch does function perfectly well the way it is and provides no 
breakage. I'm aiming for both patch-sets to be sucked into the v3.5 
merge window in any case, so all functionality will be provided at -rc1. 
Only the bleeding edge, hardcore, kernel developers who use the 
gpio-nomadik driver (so, just me and Linus Walleij then :D ) will ever 
use this code as-is.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
