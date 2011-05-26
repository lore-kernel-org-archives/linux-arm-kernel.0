From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 May 2011 17:20:23 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306426148.2497.83.camel@laptop>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526154508.GA13788@redhat.com> <1306425584.2497.81.camel@laptop>
	<1306426148.2497.83.camel@laptop>
Message-ID: <1306426823.27474.241.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 18:09 +0200, Peter Zijlstra wrote:
> On Thu, 2011-05-26 at 17:59 +0200, Peter Zijlstra wrote:
> > On Thu, 2011-05-26 at 17:45 +0200, Oleg Nesterov wrote:
> > > Stupid question. Can't we fix this problem if we do
> > > 
> > >         -       if (p == current)
> > >         +       if (cpu == raw_smp_processor_id())
> > > 
> > > ?
> > > 
> > > I forgot the rules... but iirc task_cpu(p) can't be changed under us?
> > 
> > Easy enough to test.. brain gave out again,. hold on ;-)
> 
> The below seems to run all-right so far, I'll let it run for a while.

Doesn't look very good here. The serial console basically locks up as
soon as the system gets busy, even if the kernel compilation seem to
progress at a decent pace.

	M.

-- 
Reality is an implementation detail.
