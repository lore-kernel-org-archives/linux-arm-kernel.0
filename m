From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Dec 2016 11:08:45 +0000
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock
 counter
In-Reply-To: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
References: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
Message-ID: <20161202110845.GC8266@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 01:44:55PM +0530, Srinivas Ramana wrote:
> Extend the trace_clock to support the arch timer cycle
> counter so that we can get the monotonic cycle count
> in the traces. This will help in correlating the traces with the
> timestamps/events in other subsystems in the soc which share
> this common counter for driving their timers.

I'm not sure I follow this reasoning. What's wrong with nanoseconds? In
particular, the "perf" trace_clock hangs off sched_clock, which should
be backed by the architected counter anyway. What does the cycle counter in
isolation tell you, given that the frequency isn't architected?

I think I'm missing something here.

Will
