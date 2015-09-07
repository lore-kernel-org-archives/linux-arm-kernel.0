From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 7 Sep 2015 16:58:46 +0200 (CEST)
Subject: [RFC PATCH v1 2/4] irqchip: GICv3: set non-percpu irqs status
 with _IRQ_MOVE_PCNTXT
In-Reply-To: <55EDA5A5.9070805@arm.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-3-git-send-email-yangyingliang@huawei.com>
 <55EBD59B.4030405@linux.intel.com> <55ED83D2.90809@arm.com>
 <alpine.DEB.2.11.1509071502080.15006@nanos>
 <55EDA5A5.9070805@arm.com>
Message-ID: <alpine.DEB.2.11.1509071657320.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Sep 2015, Marc Zyngier wrote:
> On 07/09/15 14:24, Thomas Gleixner wrote:
> > The history of this flag is as follows:
> > 
> > On x86 interrupts can only be safely migrated while the interrupt is
> > handled.
> 
> Woa! That's creative! :-) I suppose this doesn't work very well with CPU
> hotplug though...

Go figure ....
 
> So I wonder why we bother introducing the IRQ_MOVE_PCNTXT flag on ARM at
> all. Is that just because migration.c is only compiled when
> GENERIC_PENDING_IRQ is set?

Looks like. We can distangle that, if this code needs to be reusable.

Thanks,

	tglx
