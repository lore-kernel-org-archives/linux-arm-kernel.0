From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 25 May 2011 19:43:22 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110525150153.GE29179@elte.hu>
References: <20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
	<alpine.LFD.2.02.1105242239230.3078@ionos>
	<20110525150153.GE29179@elte.hu>
Message-ID: <1306345402.21578.100.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 17:01 +0200, Ingo Molnar wrote:
> > We do _NOT_ make any decision based on the trace point so what's the
> > "pre-existing" active role in the syscall entry code?
> 
> The seccomp code we are discussing in this thread. 

That isn't pre-existing, that's proposed.

But face it, you can argue until you're blue in the face, but both tglx
and I will NAK any and all patches that extend perf/ftrace beyond the
passive observing role.

Your arguments appear to be as non-persuasive to us as ours are to you,
so please drop this endeavor and let the security folks sort it on their
own and let's get back to doing useful work. 
