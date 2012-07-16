From: jason77.wang@gmail.com (Hui Wang)
Date: Mon, 16 Jul 2012 14:35:52 +0800
Subject: [PATCH 3/3] ARM: convert asm/irqflags.h to use
 asm-generic/irqflags.h
In-Reply-To: <1342410836-6010-4-git-send-email-robherring2@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-4-git-send-email-robherring2@gmail.com>
Message-ID: <5003B648.30802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> By implmenting arch_local_irq_restore with constant flags, we can use
> asm-generic/irqflags.h and remove some of the ARM version of irqflags.h.
>
>   
[...]
> -		: "r" (flags)
> -		: "memory", "cc");
> -}
> -
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
>  	return flags & PSR_I_BIT;
>  }
> +#define arch_irqs_disabled_flags arch_irqs_disabled_flags
> +
>   
Why don't directly define arch_irqs_disabled_flags like that:

#define arch_irqs_disabled_flags(flags) (flags & PSR_I_BIT)

> +#include <asm-generic/irqflags.h>
>  
>  #endif
>  #endif
>   
