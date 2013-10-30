From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 30 Oct 2013 16:30:31 +0100 (CET)
Subject: [PATCH V2 2/7] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
In-Reply-To: <1383145040-15852-3-git-send-email-r.sricharan@ti.com>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
 <1383145040-15852-3-git-send-email-r.sricharan@ti.com>
Message-ID: <alpine.DEB.2.02.1310301615430.24686@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Oct 2013, Sricharan R wrote:
> +static inline const u32 allocate_free_irq(int cb_no)

I understand the "static inline" part, but "const u32" is more than
fishy. What's wrong with "static inline int" ?

> +{
> +	int i;
> +
> +	for (i = 0; i < cb->int_max; i++) {
> +		if (cb->irq_map[i] == IRQ_FREE) {
> +			cb->irq_map[i] = cb_no;
> +			return i;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}

> +static int crossbar_domain_xlate(struct irq_domain *d,
> +				 struct device_node *controller,
> +				 const u32 *intspec, unsigned int intsize,
> +				 unsigned long *out_hwirq,
> +				 unsigned int *out_type)
> +{
> +	unsigned long ret = 0;

Why do you need to initialize ret when you assign a value to it in the
next line?

Thanks,

	tglx
