From: andreas.devel@googlemail.com (=?UTF-8?B?QW5kcmVhcyBCaWXDn21hbm4=?=)
Date: Wed, 01 Aug 2012 09:33:12 +0200
Subject: [PATCH] arm:gemini: fix irq.c
In-Reply-To: <4FEE13C0.10505@biessmann.de>
References: <1338981778-19938-1-git-send-email-andreas@biessmann.de>
 <4FEE13C0.10505@biessmann.de>
Message-ID: <5018DBB8.2070004@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

On 29.06.12 22:44, Andreas Bie?mann wrote:
> On 06.06.12 13:22, Andreas Bie?mann wrote:
>> Commit 9f97da78bf018206fb623cd351d454af2f105fe0 moved disable_hlt() from
>> arch/arm/include/asm/system.h to arch/arm/include/asm/system_misc.h but missed
>> to change arch/arm/mach-gemini/irq.c.
>>
>> This patch fixes following error:
>>
>> ---8<---
>> arch/arm/mach-gemini/irq.c: In function 'gemini_init_irq':
>> arch/arm/mach-gemini/irq.c:79:2: error: implicit declaration of function 'disable_hlt' [-Werror=implicit-function-declaration]
>> --->8---
>>
>> Signed-off-by: Andreas Bie?mann <andreas@biessmann.de>
>> cc: Hans Ulli Kroll <ulli.kroll@googlemail.com> 
>> cc: Russell King <linux@arm.linux.org.uk>
>> cc: linux-arm-kernel at lists.infradead.org
>> ---
>> Note: this is broken since 3.4 release, 3.3 is sane.
> 
> ping
> 
>>
>>  arch/arm/mach-gemini/irq.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
>> index ca70e5f..020852d 100644
>> --- a/arch/arm/mach-gemini/irq.c
>> +++ b/arch/arm/mach-gemini/irq.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/sched.h>
>>  #include <asm/irq.h>
>>  #include <asm/mach/irq.h>
>> +#include <asm/system_misc.h>
>>  #include <mach/hardware.h>
>>  
>>  #define IRQ_SOURCE(base_addr)	(base_addr + 0x00)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
