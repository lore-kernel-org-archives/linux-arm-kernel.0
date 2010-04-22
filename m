From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Apr 2010 13:19:32 -0400 (EDT)
Subject: Can I use VFP in work queue context ?
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BABB8676@dlee02.ent.ti.com>
References: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
	<201004221549.26344.siarhei.siamashka@nokia.com>
	<13B9B4C6EF24D648824FF11BE896716203BABB8676@dlee02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1004221314530.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Apr 2010, Woodruff, Richard wrote:

> 
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> > bounces at lists.infradead.org] On Behalf Of Siarhei Siamashka
> 
> > I also thought about the possibility to use NEON in the kernel some time ago,
> > but did not pursue it further, expecting negative feedback similar to what you
> > are getting now ;-)
> >
> > Some MMX/SSE2 code exists in the kernel already if you grep the sources. It
> > might give you some ideas. Naturally preemption has to be disabled and NEON
> > state fully saved/restored on entry/exit, like in 'kernel_fpu_begin' and
> > 'kernel_fpu_end' functions for x86. For ARM Cortex-A8 using NEON may be a bit
> > more difficult because NEON is in a separate power domain and may be switched
> > off at the time you want to use it. There may be some other technical problems
> > for sure, so the comments from someone knowledgeable would be very
> > interesting to read.
> 
> VFP/NEON executed in the kernel while in some others processes context does seem like a big no (or at least requiring details as you point out).
> 
> But a work queue is built on a half backed process which is 
> schedulable.  VFP context handling is tied to a process so it would 
> seem a smaller task to allow VFP to work against this.

You probably mean a kernel thread here, which is not the same as a work 
queue.

> If the work queue executes in a unique context it could follow the 
> same lazy strategy a user space one does.

It could... but that begs the question: what is this that requires so 
much processing power within the kernel?  This really needs to be fully 
understood and justified before even considering a possible VFP usage in 
the kernel.


Nicolas
