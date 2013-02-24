From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 24 Feb 2013 12:45:11 +0100 (CET)
Subject: question about arch/arm/mach-s3c24xx/irq.c
Message-ID: <alpine.DEB.2.02.1302241241440.1943@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function s3c24xx_irq_map in arch/arm/mach-s3c24xx/irq.c contains the
code:

                parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
		if (!irq_data) {
                        pr_err("irq-s3c24xx: no irq data found for hwirq %lu\n",
                               hw);
                        goto err;
		}

At this point irq_data has already been tested, so the null test on
irq_data does not look correct.  But I wonder if parent_irq_data could
ever be null here?

julia
