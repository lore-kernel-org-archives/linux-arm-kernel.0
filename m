From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 22:30:38 +0100
Subject: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt
 lines
In-Reply-To: <20150304194246.GF22156@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <6864616.1aRDSmSsvx@vostro.rjw.lan> <20150304194246.GF22156@leverpostej>
Message-ID: <3299261.2jupvhrEvj@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 04, 2015 07:42:46 PM Mark Rutland wrote:
> Hi Rafael,
> 
> I'm a little late to the party here, but I have just a couple of minor
> comments...
> 
> [...]
> 
> > Link: http://marc.info/?l=linux-kernel&m=142252777602084&w=2
> > Link: http://marc.info/?t=142252775300011&r=1&w=2
> > Linx: https://lkml.org/lkml/2014/12/15/552
> 
> s/x/k/ ?

Yes, thanks!

> > Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/interrupt.h |    5 +++++
> >  include/linux/irqdesc.h   |    1 +
> >  kernel/irq/manage.c       |    7 ++++++-
> >  kernel/irq/pm.c           |    7 ++++++-
> >  4 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > Index: linux-pm/include/linux/interrupt.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/interrupt.h
> > +++ linux-pm/include/linux/interrupt.h
> > @@ -57,6 +57,10 @@
> >   * IRQF_NO_THREAD - Interrupt cannot be threaded
> >   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
> >   *                resume time.
> > + * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user, execute this
> > + *                interrupt handler after suspending interrupts. For system
> > + *                wakeup devices users need to implement wakeup detection in
> > + *                their interrupt handlers.
> 
> It's probably worth documenting this in suspend-and-interrupts.txt, as
> this invalidates some of the "IRQF_NO_SUSPEND and enable_irq_wake()"
> section. I'll send a patch momentarily to that effect.
>
> Otherwise, this patch looks good, thanks for handling this!
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!
