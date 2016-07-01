From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 01 Jul 2016 15:00:57 +0100
Subject: [PATCH 07/11] arm: arm64: pmu: Assign platform PMU CPU affinity
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-8-git-send-email-jeremy.linton@arm.com>
Message-ID: <87d1mxe9uu.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

One typo below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> On systems with multiple PMU types the PMU to CPU affinity
> needs to be detected and set. The CPU to interrupt affinity
> should also be set.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 53 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2286cbf..28cac3a 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt) "hw perfevents: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -24,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  
> +#include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
>  
> @@ -872,25 +874,57 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  }
>  
>  /*
> - * CPU PMU identification and probing.
> + * CPU PMU identification and probing. Its possible to have
> + * multiple CPU types in an ARM machine. Assure that we are
                                            Assume



> + * picking the right PMU types based on the CPU in question
>   */

[...]
