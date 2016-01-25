From: james.morse@arm.com (James Morse)
Date: Mon, 25 Jan 2016 15:09:13 +0000
Subject: [PATCH 04/19] arm64: Cleanup SCTLR flags
In-Reply-To: <701b44f00cdb8dbc7881c12508f55e993b9ce6dd.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
 <701b44f00cdb8dbc7881c12508f55e993b9ce6dd.1452884156.git.geoff@infradead.org>
Message-ID: <56A63A99.2000506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 15/01/16 19:18, Geoff Levand wrote:
> We currently have macros defining flags for the arm64 sctlr registers in both
> kvm_arm.h and sysreg.h.  To clean things up and simplify move the definitions
> of the SCTLR_EL2 flags from kvm_arm.h to sysreg.h, rename any SCTLR_EL1 or
> SCTLR_EL2 flags that are common to both registers to be SCTLR_ELx, with 'x'
> indicating a common flag, and fixup all files to include the proper header or
> to use the new macro names.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 178ba22..1d7e502 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -20,7 +20,7 @@
>  #include <asm/assembler.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> -#include <asm/pgtable-hwdef.h>

I think this one crept in... this header file is needed for the
definition of TCR_T0SZ_OFFSET and TCR_TxSZ_WIDTH.


> +#include <asm/sysreg.h>
>  
>  	.text
>  	.pushsection	.hyp.idmap.text, "ax"


Thanks,

James
