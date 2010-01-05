From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 5 Jan 2010 22:26:58 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000401ca8e31$fac86820$f0593860$@deacon@arm.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<000401ca8e31$fac86820$f0593860$@deacon@arm.com>
Message-ID: <20100105222657.GK4179@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Jan 05, 2010 at 06:07:44PM -0000, Will Deacon wrote:
> I've been trying to test your patches with a quad-core ARM 11MPCore on a
> Realview PB11MP board.
> 
> Unfortunately, I occasionally experience a complete system hang during some
> profiling runs. I don't think it's your fault however, as it can occur even
> when monitoring only software events. I've managed to reproduce this on the 
> tip/master branch and got the following information [I enabled lock debugging]:
Could it be to do with the fact that perf_event_task_sched_in() expects
interrupts to be disabled but on ARM we have __ARCH_WANT_INTERRUPTS_ON_CTXSW
defined and therefore run with interrupts enabled? If so, I'm not sure what
the fix is!

At the moment, ARM is the only platform that context switches with interrupts
enabled and has perf event support.

Jamie
