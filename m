From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 22:23:46 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130195129.GA19172@pengutronix.de>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130195129.GA19172@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0911302216030.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009, Uwe Kleine-K?nig wrote:
> I think there is
> 
>  3) you can only benefit from decent priority hardware if irqs are
>     processed while irqs are enabled.
> 
> I think 
> 
> 	git grep handle_fasteoi_irq
> 
> gives an overview here: some hits in arch/powerpc, arch/sparc and
> arch/x86/kernel/apic/io_apic.c.  (There is handle_prio_irq in

No. That handler is not an indicator for prio hardware actively used
in the sense of allowing higher prio interrupts to interrupt a current
running lower priority one. It can be used when the irq controller
does not fire the interrupt again before the eoi acknowledge has been
done.

Thanks,

	tglx
