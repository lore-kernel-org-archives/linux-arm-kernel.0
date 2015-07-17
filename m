From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 13:59:56 +0100
Subject: [PATCH 1/5] arm64: kernel: preparatory: Move config_sctlr_el1
In-Reply-To: <1437062519-18883-2-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-2-git-send-email-james.morse@arm.com>
Message-ID: <20150717125955.GG13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:01:55PM +0100, James Morse wrote:
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -16,6 +16,7 @@
>  
>  #include <asm/insn.h>
>  #include <asm/opcodes.h>
> +#include <asm/sysreg.h>
>  #include <asm/system_misc.h>
>  #include <asm/traps.h>
>  #include <asm/uaccess.h>
> @@ -504,16 +505,6 @@ ret:
>  	return 0;
>  }
>  
> -static inline void config_sctlr_el1(u32 clear, u32 set)
> -{
> -	u32 val;
> -
> -	asm volatile("mrs %0, sctlr_el1" : "=r" (val));
> -	val &= ~clear;
> -	val |= set;
> -	asm volatile("msr sctlr_el1, %0" : : "r" (val));
> -}

My ack still stands on this patch but please also move the SCTLR_EL1_*
definitions from asm/cputype.h into asm/sysreg.h (together with this
function).

Thanks.

-- 
Catalin
