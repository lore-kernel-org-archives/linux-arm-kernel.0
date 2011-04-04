From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 04 Apr 2011 09:26:19 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <201104040259.26601.arnd@arndb.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104031726.37420.arnd@arndb.de>
	<20110403160324.GA8050@n2100.arm.linux.org.uk>
	<201104040259.26601.arnd@arndb.de>
Message-ID: <1301905579.417.16.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-04 at 02:59 +0200, Arnd Bergmann wrote:

> Abstracting sched_clock() to be run-time selected is something that
> needs to be taken care of. Maybe we could have a generic sched_clock
> implementation that is written on top of clocksource instead of jiffies,
> and always select that on architectures that have a decent clocksource.
> Are there any platforms on ARM where that would be a bad idea? I believe
> the main reaons why they are separate is that on x86 you can use the TSC
> for sched_clock in many cases where you cannot use it for clocksource.

I've proposed a mechanism for a run-time selectable sched_clock()
implementation as part of my A15 timer patch set:
http://www.spinics.net/lists/arm-kernel/msg116891.html
and more specifically patches #10 and #11.

I'm not completely pleased with it (the fact that it embeds a copy of
the generic sched_clock() to be used as a default is properly ugly), but
maybe this could be used as a base for further discussion.

Cheers,

	M.
-- 
Reality is an implementation detail.
