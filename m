From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 11:10:47 -0500
Subject: [PATCH 3/3] ARM: convert asm/irqflags.h to use
 asm-generic/irqflags.h
In-Reply-To: <5003B648.30802@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-4-git-send-email-robherring2@gmail.com>
 <5003B648.30802@gmail.com>
Message-ID: <50043D07.7050608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 01:35 AM, Hui Wang wrote:
> Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> By implmenting arch_local_irq_restore with constant flags, we can use
>> asm-generic/irqflags.h and remove some of the ARM version of irqflags.h.
>>
>>   
> [...]
>> -        : "r" (flags)
>> -        : "memory", "cc");
>> -}
>> -
>>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>>  {
>>      return flags & PSR_I_BIT;
>>  }
>> +#define arch_irqs_disabled_flags arch_irqs_disabled_flags
>> +
>>   
> Why don't directly define arch_irqs_disabled_flags like that:
> 
> #define arch_irqs_disabled_flags(flags) (flags & PSR_I_BIT)

In most cases, I think inlines are preferred as they have type checking.
Doesn't really matter to me.

Rob

> 
>> +#include <asm-generic/irqflags.h>
>>  
>>  #endif
>>  #endif
>>   
> 
