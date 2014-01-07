From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 7 Jan 2014 13:31:11 -0500
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <20140107163629.GC3350@e103592.cambridge.arm.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <201401071533.35309.arnd@arndb.de>
 <20140107144130.GJ27432@n2100.arm.linux.org.uk>
 <4325142.7drL5ndxN9@wuerfel>
 <20140107163629.GC3350@e103592.cambridge.arm.com>
Message-ID: <20140107133111.0fe49c21@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jan 2014 16:36:29 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> My other concern was that we might end up in a recursive trace due to
> the use of non-notrace core functions in the unwinder.  But I seem to
> remember Steve Rostedt saying the the tracer guards against recursive
> invocation nowadays -- if so, that shouldn't be a problem.

I guess it matters what type of tracing you are talking about. The
function tracer protects against all recursive contexts (normal,
softirq, irq and NMI) and so does the ring buffer (same levels).

Those may be the only ones that matter, as things like events shouldn't
recurse, unless you have an event in the unwinder itself. But that's
where you take the doctor's advice of "don't do that".

-- Steve
