From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Sat, 7 May 2011 16:05:08 -0300
Subject: [PATCH] ARM: Do not use__init annotations to declarations
In-Reply-To: <1302388820-18783-1-git-send-email-festevam@gmail.com>
References: <1302388820-18783-1-git-send-email-festevam@gmail.com>
Message-ID: <4DC597E4.2030003@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 4/9/2011 7:40 PM, Fabio Estevam wrote:
> According to Russell King (https://lkml.org/lkml/2011/4/5/323), __init should not be
> used in function declarations. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/include/asm/hardware/cache-l2x0.h    |    2 +-
>  arch/arm/include/asm/hardware/cache-tauros2.h |    2 +-
>  arch/arm/include/asm/kprobes.h                |    2 +-
>  arch/arm/include/asm/traps.h                  |    2 +-
>  arch/arm/include/asm/unwind.h                 |    4 ++--
>  arch/arm/kernel/tcm.h                         |    2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 16bd480..407c849 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -73,7 +73,7 @@
>  #define L2X0_AUX_CTRL_EARLY_BRESP_SHIFT		30
>  
>  #ifndef __ASSEMBLY__
> -extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
> +extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
>  #endif
>  
>  #endif
> diff --git a/arch/arm/include/asm/hardware/cache-tauros2.h b/arch/arm/include/asm/hardware/cache-tauros2.h
> index 538f17c..890f73f 100644
> --- a/arch/arm/include/asm/hardware/cache-tauros2.h
> +++ b/arch/arm/include/asm/hardware/cache-tauros2.h
> @@ -8,4 +8,4 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -extern void __init tauros2_init(void);
> +extern void tauros2_init(void);
> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> index bb8a19b..139e4db 100644
> --- a/arch/arm/include/asm/kprobes.h
> +++ b/arch/arm/include/asm/kprobes.h
> @@ -73,6 +73,6 @@ enum kprobe_insn {
>  
>  enum kprobe_insn arm_kprobe_decode_insn(kprobe_opcode_t,
>  					struct arch_specific_insn *);
> -void __init arm_kprobe_decode_init(void);
> +void arm_kprobe_decode_init(void);
>  
>  #endif /* _ARM_KPROBES_H */
> diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
> index f90756d..f148047 100644
> --- a/arch/arm/include/asm/traps.h
> +++ b/arch/arm/include/asm/traps.h
> @@ -43,7 +43,7 @@ static inline int in_exception_text(unsigned long ptr)
>  	return in ? : __in_irqentry_text(ptr);
>  }
>  
> -extern void __init early_trap_init(void);
> +extern void early_trap_init(void);
>  extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
>  extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
>  
> diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
> index a5edf42..126cedd 100644
> --- a/arch/arm/include/asm/unwind.h
> +++ b/arch/arm/include/asm/unwind.h
> @@ -50,9 +50,9 @@ extern void unwind_table_del(struct unwind_table *tab);
>  extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk);
>  
>  #ifdef CONFIG_ARM_UNWIND
> -extern int __init unwind_init(void);
> +extern int unwind_init(void);
>  #else
> -static inline int __init unwind_init(void)
> +static inline int unwind_init(void)
>  {
>  	return 0;
>  }
> diff --git a/arch/arm/kernel/tcm.h b/arch/arm/kernel/tcm.h
> index 8015ad4..6e849f3 100644
> --- a/arch/arm/kernel/tcm.h
> +++ b/arch/arm/kernel/tcm.h
> @@ -8,7 +8,7 @@
>   */
>  
>  #ifdef CONFIG_HAVE_TCM
> -void __init tcm_init(void);
> +void tcm_init(void);
>  #else
>  /* No TCM support, just blank inlines to be optimized out */
>  inline void tcm_init(void)

Is this patch OK?

Regards,

Fabio Estevam
