From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Jul 2013 15:45:01 -0400 (EDT)
Subject: [PATCH 0/5] ARM: DT: remove redundant DT related code
In-Reply-To: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <alpine.LFD.2.03.1307231543480.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi,
> 
> As part of my changes to remove duplicate code for parsing cpu nodes
> in the device tree, I found few unnecessary code mostly around smp_init_cpus.
> Most of the ARM Cortex A9 based platforms use SCU to get the number of cpus
> while many others depend on the device tree.
> 
> Even on DT based platforms using SCU, they can be made to depend on DT
> to cpu count simplifying smp_init_cpus. In fact arm_dt_init_cpu_maps called
> before smp_init_cpus, already does the device tree parsing, validating
> nr_cpu_ids and setting the cpu_possible_mask appropriately. 
> 
> However this series targets only the platforms using DT for cpu count
> (i.e. not using SCU)
> 
> Regards,
> Sudeep
For the whole series:

Acked-by: Nicolas Pitre <nico@linaro.org>


> Sudeep KarkadaNagesha (5):
>   ARM: keystone: remove redundant smp_init_cpus definition
>   ARM: vexpress: remove redundant vexpress_dt_cpus_num to get cpu count
>   ARM: mach-mvebu: remove redundant DT parsing and validation
>   ARM: highbank: remove redundant smp_init_cpus definition
>   ARM: zynq: remove unnecessary setting of cpu_present_mask
> 
>  arch/arm/mach-highbank/platsmp.c | 22 ----------------------
>  arch/arm/mach-keystone/platsmp.c |  1 -
>  arch/arm/mach-mvebu/platsmp.c    | 19 +------------------
>  arch/arm/mach-vexpress/platsmp.c | 32 +-------------------------------
>  arch/arm/mach-zynq/platsmp.c     |  9 ---------
>  5 files changed, 2 insertions(+), 81 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
