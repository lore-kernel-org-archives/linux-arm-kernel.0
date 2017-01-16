From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 16 Jan 2017 10:06:37 +0100 (CET)
Subject: [RFC PATCH v2 05/10] genirq: export irq_get_percpu_devid_partition
 to modules
In-Reply-To: <1484323429-15231-6-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-6-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.DEB.2.20.1701161006240.3877@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jan 2017, Will Deacon wrote:

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

Acked-by: Thomas Gleixner <tglx@linutronix.de>
