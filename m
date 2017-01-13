From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2017 19:04:30 +0000
Subject: [RFC PATCH v2 05/10] genirq: export
 irq_get_percpu_devid_partition to modules
In-Reply-To: <1484323429-15231-6-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-6-git-send-email-will.deacon@arm.com>
Message-ID: <0726dbba-0a68-aa99-4ebf-aa2e89f2a9bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 16:03, Will Deacon wrote:
> Any modular driver using cluster-affine PPIs needs to be able to call
> irq_get_percpu_devid_partition so that it can enable the IRQ on the
> correct subset of CPUs.
> 
> This patch exports the symbol so that it can be called from within a
> module.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/irq/irqdesc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 00bb0aeea1d0..1e6ae73eae59 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -856,6 +856,7 @@ int irq_get_percpu_devid_partition(unsigned int irq, struct cpumask *affinity)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(irq_get_percpu_devid_partition);
>  
>  void kstat_incr_irq_this_cpu(unsigned int irq)
>  {
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
