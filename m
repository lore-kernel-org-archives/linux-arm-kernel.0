From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 22 Feb 2013 15:18:10 +0100
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <1361542150.26780.64.camel@laptop>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361522767.26780.44.camel@laptop>
 <20130222125019.GC17948@somewhere.redhat.com>
 <1361542150.26780.64.camel@laptop>
Message-ID: <20130222141810.GB9606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2013-02-22 at 13:50 +0100, Frederic Weisbecker wrote:
> > > Argh!! at what cost? 64bit atomics are like expensive. Wouldn't
> > adding
> > > a seqlock be saner?
> > 
> > Not sure. This requires a spinlock in the write side which is called
> > from
> > fast path like the timer interrupt.
> 
> A single spinlock is _way_ cheaper than a ton of cmpxchg8b()s 
> to update a few variables.

Every cmpxchg8b() will be roughly as expensive as a spinlock 
acquire+release fastpath.

Thanks,

	Ingo
