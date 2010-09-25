From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Sep 2010 19:58:05 +0100
Subject: [PATCH] ARM: SECCOMP support
In-Reply-To: <alpine.LFD.2.00.1009251220420.13233@xanadu.home>
References: <alpine.LFD.2.00.1009231709230.13233@xanadu.home>
	<20100925113413.GA3044@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1009251220420.13233@xanadu.home>
Message-ID: <20100925185805.GB3044@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 25, 2010 at 12:31:07PM -0400, Nicolas Pitre wrote:
> Well, for one thing, the syscall tracing has the ability to change the 
> actual syscall number.  So this looked like a possible hole that could 
> somehow be exploited to escape the seccomp control.  So I went with the 
> safest way.

That is also true for x86 - the seccomp test on x86 is done first,
before the syscall entry trap.
