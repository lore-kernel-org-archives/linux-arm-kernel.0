From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 10 Nov 2009 09:22:00 +0200
Subject: enabling EXT_WAKEUP interrupts on PXA3xx
Message-ID: <4AF91498.3060503@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

We need to enable EXT_WAKEUP interrupts on PXA3xx and I wonder what would be the
best way to do it.
I see two possibilities:
1) add 'if (irq == IRQ_WAKEUPx)' statements to pxa_{un}mask_irq functions in
arch/arm/mach-pxa/irq.c
2) register additional irq_chip in arch/arm/mach-pxa/pxa3xx.c that will be
responsible for handling EXT_WAKEUP (and probably other pxa3xx specific) interrupts.

What do you prefer?

-- 
Sincerely yours,
Mike.
