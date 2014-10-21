From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Oct 2014 09:27:27 +0200 (CEST)
Subject: [PATCH v7 05/10] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <1413875672-7894-6-git-send-email-linux@rempel-privat.de>
References: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
 <1413875672-7894-6-git-send-email-linux@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1410210924140.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014, Oleksij Rempel wrote:
>  static void icoll_unmask_irq(struct irq_data *d)
>  {
> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
> -			icoll_priv.intr + SET_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
> +	mutex_lock(&icoll_lock);

And how's that supposed to work? You certainly did not run this code
with even the simplest debugging options enabled. Not to talk about
lockdep or such.

Thanks,

	tglx
