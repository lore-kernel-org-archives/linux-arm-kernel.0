From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Dec 2013 09:53:35 +0100
Subject: [PATCH 3/3] ARM: mvebu: make armada_370_xp_pmsu_init() static
In-Reply-To: <1387788491-3168-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1387788491-3168-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <52B7FA0F.7030709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 23/12/2013 09:48, Thomas Petazzoni wrote:
> The armada_370_xp_pmsu_init() function is called as an
> early_initcall(). Therefore, there is no need to export this function,
> and we can make it static.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/common.h | 1 -
>  arch/arm/mach-mvebu/pmsu.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index f7ad45e..8de509a 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -24,7 +24,6 @@ void armada_370_xp_handle_irq(struct pt_regs *regs);
>  
>  void armada_xp_cpu_die(unsigned int cpu);
>  int armada_370_xp_coherency_init(void);
> -int armada_370_xp_pmsu_init(void);
>  void armada_xp_secondary_startup(void);
>  extern struct smp_operations armada_xp_smp_ops;
>  #endif
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 27fc4f0..f614727 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -58,7 +58,7 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
>  }
>  #endif
>  
> -int __init armada_370_xp_pmsu_init(void)
> +static int __init armada_370_xp_pmsu_init(void)
>  {
>  	struct device_node *np;
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
