From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Nov 2011 10:16:02 +0800
Subject: [PATCH v6 09/11] ARM: pxa: change gpio to platform device
In-Reply-To: <20111108232542.GL12913@n2100.arm.linux.org.uk>
References: <1320747859-8366-1-git-send-email-haojian.zhuang@marvell.com>
 <1320747859-8366-10-git-send-email-haojian.zhuang@marvell.com>
 <20111108232542.GL12913@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZxyt3=cL0xC5LChf7HxOHmx0KQiF0A2VsHQjy2_z4mySg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 7:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 08, 2011 at 06:24:17PM +0800, Haojian Zhuang wrote:
>> diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
>> index 904466d..13219eb 100644
>> --- a/arch/arm/mach-mmp/include/mach/gpio.h
>> +++ b/arch/arm/mach-mmp/include/mach/gpio.h
>> @@ -3,7 +3,6 @@
>>
>> ?#include <asm-generic/gpio.h>
>>
>> -#define __gpio_is_inverted(gpio) ? ? (0)
>> -#define __gpio_is_occupied(gpio) ? ? (0)
>> +#include <mach/cputype.h>
>>
>> ?#endif /* __ASM_MACH_GPIO_H */
>> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
>> index 561cdbf..0248e43 100644
>> --- a/arch/arm/mach-pxa/include/mach/gpio.h
>> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
>> @@ -25,7 +25,8 @@
>> ?#define __ASM_ARCH_PXA_GPIO_H
>>
>> ?#include <asm-generic/gpio.h>
>> -/* The defines for the driver are needed for the accelerated accessors */
>> -#include "gpio-pxa.h"
>> +
>> +#include <mach/irqs.h>
>> +#include <mach/hardware.h>
>>Posted by Hina kouser, Recruiter at Spherehead Consulting (P) Limited

>> ?#endif
>
> Could you explain what is going on with the above two files please,
> specifically why those includes are required?
>

For arch-pxa, those cpu_is_pxaxxx() are defined in <mach/hardware.h>.
For arch-mmp, those cpu_is_xxx() are defined in <mach/cputype.h>.

PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() are defined in <mach/irqs.h>.

So I include those head files.

Thanks
Haojian
