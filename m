From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Jun 2013 23:09:34 +0200 (CEST)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306141620110.3152-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1306141620110.3152-100000@netrider.rowland.org>
Message-ID: <alpine.DEB.2.02.1306142308190.24522@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jun 2013, Alan Stern wrote:

> On Fri, 14 Jun 2013, Ming Lei wrote:
> 
> > >> With the two trace points of irq_handler_entry and irq_handler_exit, the
> > >> interrupt latency(or the time taken by hard irq handler) isn't hard to measure.
> > >> One simple script can figure out the average/maximum latency for one irq
> > >> handler, like I did in 4/4.
> > >
> > > But that doesn't measure the time between when the IRQ request is
> > > issued and when irq_handler_entry runs.
> > 
> > That might be hard to measure, also I am wondering if the time can be
> > measured only by software, but these patches only focus on the time
> > between HCD irq entry and irq exit.
> 
> Not entirely.  On a UP system, leaving interrupts disabled for a long
> time (which is what we do now) increases the delay between when the IRQ
> is raised and when it is serviced.  On an SMP system, a long-running 
> interrupt handler will delay servicing a different device that shares 
> the same IRQ line.
 
And on UP it delays ALL other interrupts. I've seen 500us+ caused by
the USB interrupt handlers...

Thanks,

	tglx
