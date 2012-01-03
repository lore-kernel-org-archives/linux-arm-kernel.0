From: dirac3000@gmail.com (dirac3000)
Date: Tue, 03 Jan 2012 18:13:14 +0100
Subject: DMA: PL330: support for multiple irqs?
Message-ID: <4F03372A.6050809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have noticed the current PL330 driver does not provide any support for
multiples interrupts, even if the controller allows such implementation
(e.g.: one interrupt line for channel).

So far the driver takes the first element of the IRQ field in the
amba_device structure and makes a request on that IRQ, but I am working
on a PL330 with 7 different IRQ lines (6 for events + 1 for irq_abort).

A possibility would be to change the driver to loop over the
amba_device->irq array, but this is limited to max 2 IRQs, and I don't
understand this limitation.

Has anybody worked on a similar configuration?
