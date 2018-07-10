From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Jul 2018 22:21:53 +0200 (CEST)
Subject: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer
 cpumask to cpu_possible_mask
In-Reply-To: <a8979e78-9844-160a-a758-631505924bbd@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
 <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
 <alpine.DEB.2.21.1807100008100.1590@nanos.tec.linutronix.de>
 <b98e0d87-3d9a-9b0c-23c4-7b289cc79a97@arm.com>
 <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de>
 <a8979e78-9844-160a-a758-631505924bbd@arm.com>
Message-ID: <alpine.DEB.2.21.1807102220320.1588@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2018, Sudeep Holla wrote:
> On 10/07/18 13:21, Thomas Gleixner wrote:
> >> Also only few ARM clocksource drivers use cpu_all_mask which could be
> >> result of copy-paste, we can even fix them too.
> >>
> >> arm_arch_timer.c:	clk->cpumask = cpu_all_mask;
> >> tegra20_timer.c:	tegra_clockevent.cpumask = cpu_all_mask;
> >> timer-atcpit100.c:	.cpumask = cpu_all_mask,
> >> timer-keystone.c:	event_dev->cpumask = cpu_all_mask;
> >> zevio-timer.c:		timer->clkevt.cpumask	= cpu_all_mask;
> > 
> > Yes, that makes sense. What we could do is warn, when cpu_all_mask is set
> > at registration time and replace the pointer with cpu_possible_mask.
> > 
> I like this approach than having to bitwise and with cpu_possible_mask
> at all the necessary place. I will cook up a patch.

Appreciated. I'm inclined to take it for 4.18 even. Please send it along
with the fixes for the above obvious failure spots.

Thanks,

	tglx
