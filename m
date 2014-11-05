From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Nov 2014 11:28:58 +0000
Subject: [PATCHv3 2/5] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141105112858.GE32700@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 06:40:04PM +0000, Punit Agrawal wrote:
> Port support for AArch32 instruction condition code checking from arm
> to arm64.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/include/asm/opcodes.h | 1 +
>  arch/arm64/kernel/Makefile       | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/opcodes.h
> 
> diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
> new file mode 100644
> index 0000000..4e603ea
> --- /dev/null
> +++ b/arch/arm64/include/asm/opcodes.h
> @@ -0,0 +1 @@
> +#include <../../arm/include/asm/opcodes.h>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 5bd029b..798f7d7 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -18,7 +18,9 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
>  			   cpuinfo.o
>  
>  arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
> -					   sys_compat.o
> +					   sys_compat.o 			\
> +					   $(addprefix ../../arm/kernel/,	\
> +						opcodes.o)

Apart from the addprefix that Russell mentioned:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
