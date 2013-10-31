From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 31 Oct 2013 10:57:47 +0000
Subject: [PATCH V2 2/7] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
In-Reply-To: <alpine.DEB.2.02.1310301615430.24686@ionos.tec.linutronix.de>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
 <1383145040-15852-3-git-send-email-r.sricharan@ti.com>,
 <alpine.DEB.2.02.1310301615430.24686@ionos.tec.linutronix.de>
Message-ID: <F934AE11CE617240AE4A874A49F629E4832579@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
  Again sorry for top post. 

  I agree and will fix both of the comments below.

  Thanks for the reviews.

Regards,
 Sricharan
________________________________________
From: Thomas Gleixner [tglx at linutronix.de]
Sent: Wednesday, October 30, 2013 9:00 PM
To: R, Sricharan
Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; linus.walleij at linaro.org; linux at arm.linux.org.uk; tony at atomide.com; Nayak, Rajendra; marc.zyngier at arm.com; grant.likely at linaro.org; mark.rutland at arm.com; robherring2 at gmail.com; Shilimkar, Santosh; Rob Herring
Subject: Re: [PATCH V2 2/7] DRIVERS: IRQCHIP: CROSSBAR: Add support for Crossbar IP

On Wed, 30 Oct 2013, Sricharan R wrote:
> +static inline const u32 allocate_free_irq(int cb_no)

I understand the "static inline" part, but "const u32" is more than
fishy. What's wrong with "static inline int" ?

> +{
> +     int i;
> +
> +     for (i = 0; i < cb->int_max; i++) {
> +             if (cb->irq_map[i] == IRQ_FREE) {
> +                     cb->irq_map[i] = cb_no;
> +                     return i;
> +             }
> +     }
> +
> +     return -ENODEV;
> +}

> +static int crossbar_domain_xlate(struct irq_domain *d,
> +                              struct device_node *controller,
> +                              const u32 *intspec, unsigned int intsize,
> +                              unsigned long *out_hwirq,
> +                              unsigned int *out_type)
> +{
> +     unsigned long ret = 0;

Why do you need to initialize ret when you assign a value to it in the
next line?

Thanks,

        tglx
