From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 13 Jan 2012 14:29:06 +0000
Subject: [PATCH v2 6/7] ARM: highbank: remove incorrect BSYM usage
In-Reply-To: <1326389476-11569-7-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
 <1326389476-11569-7-git-send-email-robherring2@gmail.com>
Message-ID: <20120113142906.GG2227@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 11:31:15AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> BSYM macro is only needed for assembly files and its usage in c files is
> wrong, so remove it. The linker will correctly set bit 0 for Thumb2
> kernels.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Dave Martin <dave.martin@linaro.org>

Acked-by: Dave Martin <dave.martin@linaro.org>

> ---
>  arch/arm/mach-highbank/highbank.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 804c4a5..7afbe1e 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -25,7 +25,6 @@
>  #include <linux/smp.h>
>  
>  #include <asm/cacheflush.h>
> -#include <asm/unified.h>
>  #include <asm/smp_scu.h>
>  #include <asm/hardware/arm_timer.h>
>  #include <asm/hardware/timer-sp.h>
> @@ -76,7 +75,7 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
>  #ifdef CONFIG_SMP
>  	cpu = cpu_logical_map(cpu);
>  #endif
> -	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
> +	writel(virt_to_phys(jump_addr), HB_JUMP_TABLE_VIRT(cpu));
>  	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
>  	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
>  			  HB_JUMP_TABLE_PHYS(cpu) + 15);
> -- 
> 1.7.5.4
> 
