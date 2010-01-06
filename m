From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 6 Jan 2010 12:14:41 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000501ca8ec9$0c790970$256b1c50$@deacon@arm.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<20100105222657.GK4179@wear.picochip.com>
	<20100105223147.GB10941@n2100.arm.linux.org.uk>
	<20100106001831.GM4179@wear.picochip.com>
	<000501ca8ec9$0c790970$256b1c50$@deacon@arm.com>
Message-ID: <20100106121441.GA21375@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2010 at 12:09:07PM -0000, Will Deacon wrote:
> Hi Jamie,
> 
> * Jamie Iles wrote:
> 
> > Ok, I've tried 2 things:
> > 	1. disabling interrupts around perf_event_task_sched_in()
> > 	2. undefining __ARCH_WANT_INTERRUPTS_ON_CTXSW
> > 
> > As far as I can tell, both of these solutions work, although with 2, I had to
> > define __ARCH_WANT_INTERRUPTS_ON_CTXSW.
> 
> I don't follow what you mean for point (2) when you say you have to define
> __ARCH_WANT_INTERRUPTS_ON_CTXSW. I tried defining __ARCH_WANT_INTERRUPTS_ON_CTXSW
> only when VIVT caches are present [as Russell mentioned], but I encountered
> further locking problems with __new_context [see below].
I got my define's mixed up. If you undef __ARCH_WANT_INTERRUPTS_ON_CTXSW then
you also need to define __ARCH_WANT_UNLOCKED_CTXSW to avoid the locking
problems you've described.
> 
> > Will, Jean - could you give the patch below a go and see if it works on your
> > systems? I don't get any lockdep warnings on my platform with this and it
> > still runs without the lock debugging.
> 
> This patch solves the issue for me. Should this be integrated into your patchset
> as that is the first perf code for ARM?
As long as no-one else has any objection.

Cheers,

Jamie
