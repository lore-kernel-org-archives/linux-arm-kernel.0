From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 4 Feb 2014 14:57:14 -0600
Subject: [PATCH v5 4/6] spmi: pmic_arb: add support for interrupt handling
In-Reply-To: <alpine.DEB.2.02.1402042107311.24986@ionos.tec.linutronix.de>
References: <1391468739-20987-1-git-send-email-joshc@codeaurora.org>
 <1391468739-20987-5-git-send-email-joshc@codeaurora.org>
 <alpine.DEB.2.02.1402042107311.24986@ionos.tec.linutronix.de>
Message-ID: <20140204205714.GN20228@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 09:10:45PM +0100, Thomas Gleixner wrote:
> On Mon, 3 Feb 2014, Josh Cartwright wrote:
> > +static void qpnpint_irq_ack(struct irq_data *d)
> > +{
> > +	struct spmi_pmic_arb_dev *pa = irq_data_get_irq_chip_data(d);
> > +	u8 irq  = d->hwirq >> 8;
> > +	u8 apid = d->hwirq;
> > +	unsigned long flags;
> > +	u8 data;
> > +
> > +	spin_lock_irqsave(&pa->lock, flags);
> 
> This wants to be a raw_spinlock - think about RT!

Indeed.  I'll change this in the next revision.

> Looks sane otherwise.

Great, thanks for taking a look!

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
