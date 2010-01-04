From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 4 Jan 2010 11:46:10 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20100104111733.GD9107@n2100.arm.linux.org.uk>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-6-git-send-email-jamie.iles@picochip.com>
	<20100104111733.GD9107@n2100.arm.linux.org.uk>
Message-ID: <20100104114610.GC4117@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 11:17:33AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2010 at 10:48:42AM +0000, Jamie Iles wrote:
> > This patch implements support for ARMv6 performance counters in the
> > Linux performance events subsystem. ARMv6 architectures that have the
> > performance counters should enable HW_PERF_EVENTS and define the
> > interrupts for the counters in arch/arm/kernel/perf_event.c
> 
> Only comment is the number of BUG()s in this code - I count 6 of them.
> BUG() is not meant to be used as an "assert" for when expectations are
> not met - does it really make sense to crash the kernel when any of
> these are hit?  Are you at risk of losing data if one of your conditions
> isn't satisfied?
> 
> You may want to consider using WARN_ON() instead - at least that doesn't
> take out the kernel.
Ok, good point. I've replaced these with WARN_ONCE()'s so we don't get too
much noise with repeated accesses.

Jamie
