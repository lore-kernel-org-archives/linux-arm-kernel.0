From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2012 15:15:43 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FF59145.2020009@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FF59145.2020009@renesas.com>
Message-ID: <20120705141542.GH3399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:06:13PM +0100, Shinya Kuribayashi wrote:
> On 6/30/2012 2:33 AM, Will Deacon wrote:
> > +extern void init_current_timer_delay(unsigned long freq);
> > +
> 
> This is needed for all users of the new timer-baed delay routine.
> How about moving this extern declaration to more generic place, in
> <asm/timex.h>?

I mentioned this before in the original posting. Currently, only the
architected timers are using this interface and I have some reservations
about using memory-mapped timers instead (although there may be specific
instances where they're suitable).

In this case, I'd rather see a registration mechanism for the current_timer
where we take a pointer to read_current_timer and register the delay at the
same time. That can be added when somebody else decides they want to make
use of the new delay routines.

> Tested-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Thanks!

Will
