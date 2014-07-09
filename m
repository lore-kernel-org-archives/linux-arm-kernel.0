From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 9 Jul 2014 09:49:46 +0200
Subject: [PATCH v3 05/12] ARM: topology: use new cpu_power interface
In-Reply-To: <1404144343-18720-6-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-6-git-send-email-vincent.guittot@linaro.org>
Message-ID: <CAP245DWoQEgotq1FAu9f=zk_-bXAQtnG-RfLWzjrmOoZaCkBDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 6:05 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> Use the new arch_scale_cpu_power in order to reflect the original capacity of

s/arch_scale_cpu_power/arch_scale_cpu_capacity and similar renames in
the commit logs across the entire patchset to take into account all
the renames in the code.

> a CPU instead of arch_scale_freq_power which is more linked to a scaling of
> the capacity linked to the frequency.

here too...

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/kernel/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index d42a7db..2310bfb 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -42,7 +42,7 @@
>   */
>  static DEFINE_PER_CPU(unsigned long, cpu_scale);
>
> -unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
> +unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
>         return per_cpu(cpu_scale, cpu);
>  }
> @@ -166,7 +166,7 @@ static void update_cpu_capacity(unsigned int cpu)
>         set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
>
>         printk(KERN_INFO "CPU%u: update cpu_capacity %lu\n",
> -               cpu, arch_scale_freq_capacity(NULL, cpu));
> +               cpu, arch_scale_cpu_capacity(NULL, cpu));
>  }
>
>  #else
> --
> 1.9.1
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
