From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jan 2015 16:55:07 +0000
Subject: [RFC 1/8] ARM64: Move BRK opcodes defines from kprobes.h to insn.h
In-Reply-To: <5beb1ff58d4928a873be5e898b62d8cc2003ec7c.1420038188.git.panand@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <5beb1ff58d4928a873be5e898b62d8cc2003ec7c.1420038188.git.panand@redhat.com>
Message-ID: <20150108165506.GP11583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 03:21:17PM +0000, Pratyush Anand wrote:
> Its better to keep all BRK opcodes used by kprobes and uprobes at one
> place. Therefore move these defines to asm/insn.h.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/arm64/include/asm/insn.h | 6 ++++++
>  arch/arm64/kernel/kprobes.h   | 7 +------
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index e2ff32a93b5c..87fa48746806 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -23,6 +23,12 @@
>  /* A64 instructions are always 32 bits. */
>  #define	AARCH64_INSN_SIZE		4
>  
> +/* BRK opcodes with ESR encoding  */
> +#define BRK64_ESR_MASK		0xFFFF
> +#define BRK64_ESR_KPROBES	0x0004
> +#define BRK64_OPCODE_KPROBES	0xD4200080	/* "brk 0x4" */

These might be better off in debug-monitors.h, but I guess that's for the
kprobes series to sort out.

> +#define ARCH64_NOP_OPCODE	0xD503201F

We have aarch64_insn_gen_nop for this.

Will
