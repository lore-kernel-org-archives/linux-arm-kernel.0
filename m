From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Jan 2015 18:53:50 +0100
Subject: [PATCH 1/3] ARM: Marvell: Remove init cpus function
In-Reply-To: <1421686381-12397-1-git-send-email-daniel.lezcano@linaro.org>
References: <1421686381-12397-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <54BD44AE.20006@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 19/01/2015 17:52, Daniel Lezcano wrote:
> With the next patches, the init cpus function will be changed to be factored
> out.
> 
> The function 'armada_xp_smp_init_cpus' does nothing more than a sanity check
> after the DT has been parsed. Even if this code is valid, it does not give a
> real benefit as the DT should be correctly filled.
> 
> Remove this callback.

In the course of the factorization of the smp functions, this function
has been more and more reduced. As stated, the remaining part is not so
useful now, it makes sens to remove it now.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index 58cc8c1..3e93422 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -30,8 +30,6 @@
>  #include "pmsu.h"
>  #include "coherency.h"
>  
> -#define ARMADA_XP_MAX_CPUS 4
> -
>  #define AXP_BOOTROM_BASE 0xfff00000
>  #define AXP_BOOTROM_SIZE 0x100000
>  
> @@ -114,14 +112,6 @@ static void armada_xp_secondary_init(unsigned int cpu)
>  	mvebu_v7_pmsu_idle_exit();
>  }
>  
> -static void __init armada_xp_smp_init_cpus(void)
> -{
> -	unsigned int ncores = num_possible_cpus();
> -
> -	if (ncores == 0 || ncores > ARMADA_XP_MAX_CPUS)
> -		panic("Invalid number of CPUs in DT\n");
> -}
> -
>  static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	struct device_node *node;
> @@ -171,7 +161,6 @@ static int armada_xp_cpu_kill(unsigned int cpu)
>  #endif
>  
>  struct smp_operations armada_xp_smp_ops __initdata = {
> -	.smp_init_cpus		= armada_xp_smp_init_cpus,
>  	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
>  	.smp_boot_secondary	= armada_xp_boot_secondary,
>  	.smp_secondary_init     = armada_xp_secondary_init,
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
