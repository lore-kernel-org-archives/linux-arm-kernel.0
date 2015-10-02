From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 03 Oct 2015 00:16 +0200
Subject: [RFC] arm: Add generic smc wrapper
In-Reply-To: <201510021338.iKkCgj7c%fengguang.wu@intel.com>
References: <201510021338.iKkCgj7c%fengguang.wu@intel.com>
Message-ID: <5702279.CAc6WZ9W2z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 13:13:24 kbuild test robot wrote:
> 
>     15  
>     16  #include <asm/opcodes-sec.h>
>     17  
>     18  /* int invoke_smc(u32 function_id, u32 arg0, u32 arg1, u32 arg2) */
>     19  ENTRY(invoke_smc)
>     20          __SMC(0)
>   > 21          bx      lr
>     22  ENDPROC(invoke_smc)
> 
> 

Maybe compile this only for ARMv6 and ARMv7? The error was for an ARMv3/v4 build,
which has neither SMC nor bx.

	Arnd
