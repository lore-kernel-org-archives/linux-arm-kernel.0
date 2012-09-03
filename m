From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 3 Sep 2012 11:19:25 +0800
Subject: [PATCH 02/10] gpio: pxa: add explicit includes for cpu_is_X macros
In-Reply-To: <CACRpkdasWv8toA1eBzpYo4QactNhkpzhuBk-D8kJbbM03WZN2Q@mail.gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-3-git-send-email-robherring2@gmail.com>
 <CACRpkdasWv8toA1eBzpYo4QactNhkpzhuBk-D8kJbbM03WZN2Q@mail.gmail.com>
Message-ID: <CAN1soZzDr4pi7zs188Rw-nQaA9ef-0VoVnwkMo=PCd0KPU22cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 6:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 29, 2012 at 3:31 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> In preparation to remove implicit inclusion of mach/gpio.h, add the
>> necessary includes for cpu_is_X macros.
>
> The commit message talks about gpio.h, but...
>
>>  #include <mach/irqs.h>
>> +#include <mach/hardware.h>
>> +#ifdef CONFIG_ARCH_MMP
>> +#include <mach/cputype.h>
>> +#endif
>
> This seems completely unrelated, but correct in the sense that every driver
> should include its resources.
>
> But isn't the proper fix to move arch/arm/mach-pxa/include/mach/cputype.h to
> include/linux/*/pxa-cputype.h or something (note: no clue what "*" should be!),
> or even better, modify this one driver to take a flag from platform data and/or
> DT?
>
> Anyway, we need the PXA maintainers to look at this.
>
> Yours,
> Linus Walleij

It's no problem to include cputype.h. I agree Linus's comments to use a same
name head file. For example, add cputype.h in arch-pxa. Use cputype.h to include
hardware.h.

My question is whether your patches are also based on Arnd's
multi-header branch.
I remember that some changes are done in his multiplatform branch. Should we
do any patches on his multiplatform branch?
