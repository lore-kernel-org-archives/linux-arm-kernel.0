From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 Sep 2013 22:18:50 +0200 (CEST)
Subject: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
In-Reply-To: <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
 <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
Message-ID: <alpine.DEB.2.02.1309122201530.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Sep 2013, Sricharan R wrote:
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
> There is lockdep warning during the boot. This is because we try to
> do one request_irq with in another and that results in kmalloc being
> called from an atomic context, which generates the warning.
> Any suggestions to overcome this will help.

You can't be serious about that. You post a patch series with a
serious bug in it instead of asking in the first place how to solve
the problem at hand.

So why do you actually need to call request_irq() from inside
request_irq() and how do you actually manage to do that at all?

I have a hard time to figure out how request_irq() might call itself
recursive. And I have no intention to look at your patch to figure out
that you abuse an irq chip callback to do so, simply because that
would force me to use abusive language which is frowned upon nowadays.

Can you please explain what you are trying to solve without referring
to your existing broken implementation.

Thanks,

	tglx
