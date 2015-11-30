From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 30 Nov 2015 12:13:02 +0100
Subject: [RFC PATCH 1/8] ARM: initialize cpu_scale to its default
In-Reply-To: <1448288921-30307-2-git-send-email-juri.lelli@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-2-git-send-email-juri.lelli@arm.com>
Message-ID: <CAKfTPtCVv_dwAu-PVfkmpCPjNMo_nnLQzr2Yc1p2oFYOORH=GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2015 at 15:28, Juri Lelli <juri.lelli@arm.com> wrote:
> Instead of looping through all cpus calling set_capacity_scale, we can
> initialise cpu_scale per-cpu variables to SCHED_CAPACITY_SCALE with their
> definition.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 08b7847..ec279d1 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -40,7 +40,7 @@
>   * to run the rebalance_domains for all idle cores and the cpu_capacity can be
>   * updated during this sequence.
>   */
> -static DEFINE_PER_CPU(unsigned long, cpu_scale);
> +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>
>  unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> @@ -306,8 +306,6 @@ void __init init_cpu_topology(void)
>                 cpu_topo->socket_id = -1;
>                 cpumask_clear(&cpu_topo->core_sibling);
>                 cpumask_clear(&cpu_topo->thread_sibling);
> -
> -               set_capacity_scale(cpu, SCHED_CAPACITY_SCALE);
>         }
>         smp_wmb();

FWIW, Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> --
> 2.2.2
>
