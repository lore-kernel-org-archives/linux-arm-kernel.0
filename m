From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Jul 2013 12:10:04 +0100
Subject: [RFC PATCH 4/5] arm64: add CPU_HOTPLUG infrastructure
In-Reply-To: <20130711093359.GF830@codeaurora.org>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
 <1373494549-24972-1-git-send-email-mark.rutland@arm.com>
 <20130711093359.GF830@codeaurora.org>
Message-ID: <20130711111003.GB13035@kartoffel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 10:33:59AM +0100, Stephen Boyd wrote:
> On 07/10, Mark Rutland wrote:
> > +void __ref cpu_die(void)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	idle_task_exit();
> > +
> > +	local_irq_disable();
> > +	mb();
> > +
> > +	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> > +	RCU_NONIDLE(complete(&cpu_died));
> 
> This isn't true anymore.

Ah. I'd missed the RCU_NONIDLE while rebasing the series. I'll fix that up.

Thanks,
Mark.
