From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 18:48:26 +0100 (CET)
Subject: [PATCH 3/5] ARM: sa1100: use ioremapped memory to access SC
 registers
In-Reply-To: <1421316574-10022-3-git-send-email-dbaryshkov@gmail.com>
References: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
 <1421316574-10022-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <alpine.DEB.2.11.1501241846540.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jan 2015, Dmitry Eremin-Solenikov wrote:
>  static void sa1100_mask_irq(struct irq_data *d)
>  {
> -	ICMR &= ~BIT(d->hwirq);
> +	u32 reg;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lock, flags);

What's the exact point of that lock? And how is it related to the
$subject of the patch?

Thanks,

	tglx
