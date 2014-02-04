From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Feb 2014 21:10:45 +0100 (CET)
Subject: [PATCH v5 4/6] spmi: pmic_arb: add support for interrupt handling
In-Reply-To: <1391468739-20987-5-git-send-email-joshc@codeaurora.org>
References: <1391468739-20987-1-git-send-email-joshc@codeaurora.org>
 <1391468739-20987-5-git-send-email-joshc@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1402042107311.24986@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Feb 2014, Josh Cartwright wrote:
> +static void qpnpint_irq_ack(struct irq_data *d)
> +{
> +	struct spmi_pmic_arb_dev *pa = irq_data_get_irq_chip_data(d);
> +	u8 irq  = d->hwirq >> 8;
> +	u8 apid = d->hwirq;
> +	unsigned long flags;
> +	u8 data;
> +
> +	spin_lock_irqsave(&pa->lock, flags);

This wants to be a raw_spinlock - think about RT!

Looks sane otherwise.

Thanks,

	tglx
