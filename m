From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Sep 2015 18:52:41 +0200 (CEST)
Subject: Regression by 01f779f4862b ("irqchip/GIC: Don't deactivate
 interrupts forwarded to a guest")
In-Reply-To: <20150917003202.498ff83c@xhacker>
References: <20150917003202.498ff83c@xhacker>
Message-ID: <alpine.DEB.2.11.1509161851330.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015, Jisheng Zhang wrote:

> Hi Marc,
> 
> Commit 01f779f4862b ("irqchip/GIC: Don't deactivate interrupts forwarded to a
> guest") causes a regression on Marvell BG4CT SoC. In this SoC, there's only one
> GIC, the secondary irq controller is Synopsys DW iCtl:
> drivers/irqchip/irq-dw-apb-ictl.c
> 
> So cascading_gic_irq() should return true on Marvell BG4CT SoC, but it returns
> false. The logic in cascading_gic_irq() doesn't take cascaded irq controller
> which is provided by non-gic controllers.

I have a fix pending for this in

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.irq

714665351cc7: irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag

Can you please give that a try?

Thanks,

	tglx
