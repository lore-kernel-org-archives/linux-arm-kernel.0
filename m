From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 May 2014 15:02:14 +0200
Subject: PXA 2xx devictree port and clock infrastructure
Message-ID: <87zji3cr3d.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I'm playing with devicetree to port the mioa701 machine code to devicetree (or
rather to eliminate the mioa701 machine code).

While porting the pxa2xx device drivers, I came to a question about the clock
infrastructure, and I'd need a bit of guidance.

Many drivers, in their probe code are doing something like :
	1) regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	2) irq = platform_get_irq(pdev, 0);
	3) clk = clk_get(&pdev->dev, NULL);

Points 1 and 2 are straightforward with DT. Point 3 is not so obvious to me.

As there is no platform data anymore, the clock infrastructure wants to match
the OF device (in my case udc at 40600000) with the registered
clocks. Unfortunately, the registered clock is named "pxa27x-udc", which works
well in "platform data" devices, but not in devicetree populated devices.

Therefore, I'd like to know what to do, and an example in another platform would
be great. Should I create a clkdev driver in drivers/clk, or is there another
... faster way ? And Daniel, you probably solved it already for
arch/arm/mach-pxa/pxa-dt.c, didn't you ?

Thanks for your insights.

Cheers.

-- 
Robert
