From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 Sep 2013 23:35:32 +0200 (CEST)
Subject: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
In-Reply-To: <20130912205417.GA539@radagast>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
 <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
 <20130912205417.GA539@radagast>
Message-ID: <alpine.DEB.2.02.1309122334370.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Sep 2013, Felipe Balbi wrote:

> On Thu, Sep 12, 2013 at 09:09:08PM +0530, Sricharan R wrote:
> > +unsigned int crossbar_request_irq(struct irq_data *d)
> > +{
> > +	int cb_no = d->hwirq;
> > +	int virq = allocate_free_irq(cb_no);
> > +	void *irq = &cb->crossbar_map[cb_no].hwirq;
> > +	int err;
> > +
> > +	err = request_threaded_irq(virq, crossbar_irq, NULL,
> > +				   0, "CROSSBAR", irq);
> 
> this is wrong, why don't you just set crossbar up as a chained handler.

That's just a detail, which does not solve the underlying problem of
the crossbar -> GIC mapping.

Thanks,

	tglx
