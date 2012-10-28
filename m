From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 09:58:31 +0100
Subject: [PATCH 1/3] irqchip: add basic infrastructure
In-Reply-To: <201210271921.17472.arnd@arndb.de>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201210271921.17472.arnd@arndb.de>
Message-ID: <20121028095831.5e685e26@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Sat, 27 Oct 2012 19:21:17 +0000, Arnd Bergmann wrote:
> On Saturday 27 October 2012, Thomas Petazzoni wrote:
> > With the recent creation of the drivers/irqchip/ directory, it is
> > desirable to move irq controller drivers here. At the moment, the only
> > driver here is irq-bcm2835, the driver for the irq controller found in
> > the ARM BCM2835 SoC, present in Rasberry Pi systems. This irq
> > controller driver was exporting its initialization function and its
> > irq handling function through a header file in
> > <linux/irqchip/bcm2835.h>.
> 
> Very nice series!

Thanks!

> I think it would be good if Thomas Gleixner as the IRQ subsystem maintainer
> could have a look as well. We should probably add the drivers/irqchip
> directory to that MAINTAINERS entry.

Sure.

There are however two things I am not entirely happy with:

 (*) For each irqchip driver, we have to enclose the entry in the
     irqchip_of_match[] array between #ifdef CONFIG... #endif. Not
     really a problem, but not very pretty either, but I don't see a
     simple around it (I don't think we want to define yet another
     custom ELF section just for the purpose of irqchip drivers
     registration).

 (*) The fact that all the irqchip drivers have to mess around directly
     with handle_arch_irq, which is an internal/architecture specific
     symbol. But since the current drivers are only compiled when a ARM
     architecture is selected, maybe it isn't a problem.

But that said, it seems like it is a good enough solution for a start.
Trying to solve those two problems would probably lead to an
over-engineered solution.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
