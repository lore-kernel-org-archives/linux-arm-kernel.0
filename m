From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Jan 2011 12:47:40 +0100 (CET)
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <4D30329F.5040201@atmel.com>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
	<4D30329F.5040201@atmel.com>
Message-ID: <alpine.LFD.2.00.1101141241330.2678@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jan 2011, Nicolas Ferre wrote:
> For AT91:
> - the platform does not provides irq_flags so default to
> IRQF_TRIGGER_FALLING | IRQF_ONESHOT as stated in the driver.
> - on at91sam9g10ek the touchscreen is wired to an full featured IRQ
> entry (configured with pullup in arch/arm/mach-at91/board-sam9261ek.c).
> - the irq description of plain interrupts is in arch/arm/mach-at91/irq.c
> and at91_aic_set_type() has an IRQ_TYPE_EDGE_FALLING entry.
> 
> So it should be configured on falling edge...
> 
> But: is seems that looking at at91_aic_set_type() initialization
> function, AIC is configured with:
> set_irq_handler(i, handle_level_irq);
> 
> I do not know if it is the same as i.MX but it sound to be covered by
> explanation that you gave...

Seems to be the same problem. 

Thanks,

	tglx
