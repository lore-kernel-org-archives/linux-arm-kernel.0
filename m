From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 10:58:51 +0000
Subject: [PATCH] arm64: include asm/assembler.h in entry-ftrace.S
In-Reply-To: <20170214213314.2910910-1-arnd@arndb.de>
References: <20170214213314.2910910-1-arnd@arndb.de>
Message-ID: <20170215105851.GC31733@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:32:58PM +0100, Arnd Bergmann wrote:
> In a randconfig build I ran into this build error:
> 
> arch/arm64/kernel/entry-ftrace.S: Assembler messages:
> arch/arm64/kernel/entry-ftrace.S:101: Error: unknown mnemonic `ldr_l' -- `ldr_l x2,ftrace_trace_function'
> 
> The macro is defined in asm/assembler.h, so we should include that file.
> 
> Fixes: 829d2bd13392 ("arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

My bad; thanks for fixing this.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/entry-ftrace.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 8f1905b795f3..e1be42e11ff5 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm/assembler.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
>  
> -- 
> 2.9.0
> 
