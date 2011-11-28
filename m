From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 11:47:14 +0000
Subject: [PATCH] ARM: cpu topology: fix warning
In-Reply-To: <1318612470-2151-1-git-send-email-vincent.guittot@linaro.org>
References: <1318612470-2151-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20111128114713.GE26946@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On Fri, Oct 14, 2011 at 06:14:30PM +0100, Vincent Guittot wrote:
> kernel/sched.c:7354:2: warning: initialization from incompatible pointer type
> 
> Align cpu_coregroup_mask prototype interface with sched_domain_mask_f typedef
> use int cpu instead of unsigned int cpu
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/include/asm/topology.h |    2 +-
>  arch/arm/kernel/topology.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index a7e457e..58b8b84 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -25,7 +25,7 @@ extern struct cputopo_arm cpu_topology[NR_CPUS];
>  
>  void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
> -const struct cpumask *cpu_coregroup_mask(unsigned int cpu);
> +const struct cpumask *cpu_coregroup_mask(int cpu);
>  
>  #else
>  
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 1040c00..8200dea 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -43,7 +43,7 @@
>  
>  struct cputopo_arm cpu_topology[NR_CPUS];
>  
> -const struct cpumask *cpu_coregroup_mask(unsigned int cpu)
> +const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
>  	return &cpu_topology[cpu].core_sibling;
>  }
> -- 
> 1.7.4.1

I'm still seeing this warning in mainline. What is your plan for merging
this fix?

Cheers,

Will
