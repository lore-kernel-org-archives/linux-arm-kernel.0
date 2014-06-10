From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 11 Jun 2014 01:34:39 +0200 (CEST)
Subject: [RFC] irqchip: gic: always mask interrupts during suspend
In-Reply-To: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
References: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <alpine.DEB.2.10.1406110129270.5170@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jun 2014, Brian Norris wrote:
> Other random thought: it seems like any irqchip driver which does lazy IRQ
> masking ought to use IRQCHIP_MASK_ON_SUSPEND. So maybe the IRQ core should just
> do something like:
> 
> 	if (!chip->irq_disable)
> 		chip->flags |= IRQCHIP_MASK_ON_SUSPEND;

No. Lazy irq disable and the suspend logic are different beasts.

That's up to the platform to decide this. Just for the record: there
is a world outside of ARM...

But that brings me to a different question:

    Why are you not putting that customization into the device tree
    instead of trying to add this to some random arch/arm/mach-foo
    files?

Thanks,

	tglx
