From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 8 Mar 2012 20:27:11 +0100 (CET)
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203081701.01663.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203072113.04369.arnd@arndb.de>
 <20120308162530.GI5050@titan.lakedaemon.net>
 <201203081701.01663.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1203082026470.2742@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Mar 2012, Arnd Bergmann wrote:

> On Thursday 08 March 2012, Jason wrote:
> > 
> > On Wed, Mar 07, 2012 at 09:13:04PM +0000, Arnd Bergmann wrote:
> > > Finally, something could be wrong with the interrupt controller.
> > > AFAICT, you register it through the device tree now, but it's also
> > > getting initialized through kirkwood_init_irq, so the numbers
> > > would all be wrong.
> > 
> > Yes, I'm working through this now.  mv_cesa silently fails to come up
> > if it can't find the interrupt controller via fdt.  So, it needs to get
> > done.
> > 
> > Right now, I'm looking at how mach-versatile does it (vic_init()) since
> > it's also an ARM926ej-s...
> > 
> 
> Ok, sounds good. It's not important whether it's an ARM9 or not btw.
> You should look at both anything that defines an "interrupt-controller"
> property as an example including Documentation/devicetree/bindings/arm/vic.txt
> and Documentation/devicetree/bindings/arm/gic.txt.
> 
> (taking Thomas Gleixner on Cc)
> 
> Since the orion irq chip is based on irqchip_generic, it would be
> perfect to have a generic irqchip binding to go along with
> kernel/irq/generic-chip.c. Not sure if anyone has thought about this
> before, but it looks like we can completely avoid using
> arch/arm/plat-orion/irq.c and arch/arm/mach-kirkwood/irq.c if we
> do that.

Right. That should be trivial to implement.
