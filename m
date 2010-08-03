From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 3 Aug 2010 14:14:57 +0900
Subject: [PATCH 1/3] ARM: S5PC110/S5PC210: Add the C Preprocessor
	directives for gpio.h
In-Reply-To: <00f001cb32c9$c21eba00$465c2e00$%kim@samsung.com>
References: <20100802002457.GA32257@july>
	<00f001cb32c9$c21eba00$465c2e00$%kim@samsung.com>
Message-ID: <AANLkTinyNSLVP4FsfXXJzyodEGB0H7xuOwtspfW8nxmR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 3, 2010 at 2:07 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Make a buile error when include the mach/gpio.h directly.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/include/mach/gpio.h | ? ?4 ++++
>> ?arch/arm/mach-s5pv310/include/mach/gpio.h | ? ?4 ++++
>> ?2 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-
>> s5pv210/include/mach/gpio.h
>> index 1f4b595..7798693 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
>> @@ -13,6 +13,10 @@
>> ?#ifndef __ASM_ARCH_GPIO_H
>> ?#define __ASM_ARCH_GPIO_H __FILE__
>>
>> +#ifndef __LINUX_GPIO_H
>> +#error "Don't include the mach/gpio.h directly. use the linux/gpio.h"
>> +#endif
>> +
>> ?#define gpio_get_value ? ? ? __gpio_get_value
>> ?#define gpio_set_value ? ? ? __gpio_set_value
>> ?#define gpio_cansleep ? ? ? ?__gpio_cansleep
>> diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-
>> s5pv310/include/mach/gpio.h
>> index 20cb80c..3f751f2 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/gpio.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
>> @@ -13,6 +13,10 @@
>> ?#ifndef __ASM_ARCH_GPIO_H
>> ?#define __ASM_ARCH_GPIO_H __FILE__
>>
>> +#ifndef __LINUX_GPIO_H
>> +#error "Don't include the mach/gpio.h directly. use the linux/gpio.h"
>> +#endif
>> +
>> ?#define gpio_get_value ? ? ? __gpio_get_value
>> ?#define gpio_set_value ? ? ? __gpio_set_value
>> ?#define gpio_cansleep ? ? ? ?__gpio_cansleep
>> --
>
> Again, Cc'ed Ben Dooks...Please add him in Cc...

I can't find any reason to cc to him. In previous time, Ben said you
take the s5p series. and that's I agreed.
I just want to contact the proper person on each patch.
If I touch the common part, I'll add him.

>
> _ARCH_ARM_GPIO_H is better...if defined it, it means including
> mach/gpio.h...
>
> Anyway...but I think we no need above warning message...because I will check
> it before merging in my tree...

It's not warning message. It can't build if someone includes the
mach/gpio.h directly.
So fix it early. No need to check it. why do you go difficult way?

> And if required, I will fix all of samsung stuff about inclusion
> mach/gpio.h...
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
