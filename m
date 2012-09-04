From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Sep 2012 09:38:58 +0800
Subject: [PATCH 02/10] gpio: pxa: add explicit includes for cpu_is_X macros
In-Reply-To: <5044CF0A.7040208@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-3-git-send-email-robherring2@gmail.com>
 <CACRpkdasWv8toA1eBzpYo4QactNhkpzhuBk-D8kJbbM03WZN2Q@mail.gmail.com>
 <CAN1soZzDr4pi7zs188Rw-nQaA9ef-0VoVnwkMo=PCd0KPU22cg@mail.gmail.com>
 <5044CF0A.7040208@gmail.com>
Message-ID: <CAN1soZw=0Phm8pb3a=x3--rb=0niXqB06RPzOgudG7S-B4rUpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 11:38 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/02/2012 10:19 PM, Haojian Zhuang wrote:
>> On Fri, Aug 31, 2012 at 6:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, Aug 29, 2012 at 3:31 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> In preparation to remove implicit inclusion of mach/gpio.h, add the
>>>> necessary includes for cpu_is_X macros.
>>>
>>> The commit message talks about gpio.h, but...
>>>
>>>>  #include <mach/irqs.h>
>>>> +#include <mach/hardware.h>
>>>> +#ifdef CONFIG_ARCH_MMP
>>>> +#include <mach/cputype.h>
>>>> +#endif
>>>
>>> This seems completely unrelated, but correct in the sense that every driver
>>> should include its resources.
>>>
>>> But isn't the proper fix to move arch/arm/mach-pxa/include/mach/cputype.h to
>>> include/linux/*/pxa-cputype.h or something (note: no clue what "*" should be!),
>>> or even better, modify this one driver to take a flag from platform data and/or
>>> DT?
>>>
>>> Anyway, we need the PXA maintainers to look at this.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> It's no problem to include cputype.h. I agree Linus's comments to use a same
>> name head file. For example, add cputype.h in arch-pxa. Use cputype.h to include
>> hardware.h.
>
> I think the right fix is really removing the use of cpu_is_X macros
> altogether.
>
We'll support non-DT mode at least half a year. So we don't plan to
remove cpu_is_X
macros so quickly.

>> My question is whether your patches are also based on Arnd's
>> multi-header branch.
>> I remember that some changes are done in his multiplatform branch. Should we
>> do any patches on his multiplatform branch?
>
> It is not based on it. We decided at the ARM mini-summit to not do the
> mach header rename and to deprecate including mach headers outside of
> arch/arm.
>
> I'm thinking I will just make PXA and MMP select CONFIG_NEED_MACH_GPIO_H
> and drop this patch. If pxa and mmp want to be included in
> multi-platform images, then this will need to be fixed.
>
> Rob

I checked with Arnd that new patches would be on his multiplatform
branch in that
summit. And mulitplatform branch is based on multiheader branch.

It's ok to enable CONFIG_NEED_MACH_GPIO_H and drop this patch.
