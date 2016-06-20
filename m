From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Jun 2016 09:34:53 +0100
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm
 via the cmdline
In-Reply-To: <20160620082157.GC29165@arm.com>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
 <5766FBC6.6000405@linaro.org> <20160620082157.GC29165@arm.com>
Message-ID: <20160620093453.214edd8e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2016 09:21:57 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Sun, Jun 19, 2016 at 10:08:38PM +0200, Daniel Lezcano wrote:
> > On 06/17/2016 03:43 PM, Will Deacon wrote:
> > 
> > [ Cc'ed tglx ]
> > 
> > >Disabling the eventstream can be useful for debugging and development
> > >purposes
> > 
> > If it is for debugging and development, why upstream this change ?
> 
> Mainly because it's desirable to be able to debug systems remotely, on
> machines that you don't have direct access to and where recompiling the
> kernel isn't necessarily an option. There are plenty of "no*" kernel
> parameters already that fall into a similar category.

I would add that being able to toggle this without affecting the memory
layout or any of the code paths is extremely valuable. The event stream
can have an effect on the spinlock behaviour (through the WFE
instruction), so having a way to exercise it without changing anything
else is pretty cool. Also, being able to debug a production kernel at
zero cost is rare enough to make me jump on the opportunity.

So for this patch, and Mark's suggestion of adding some documentation
to it:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
