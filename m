From: dwalker@fifo99.com (Daniel Walker)
Date: Mon, 26 Apr 2010 16:48:14 -0700
Subject: Q: sched_clock() vs. clocksource, how to implement correctly
In-Reply-To: <20100423182933.0df45b53@mschwide.boeblingen.de.ibm.com>
References: <20100423150917.GA25714@sig21.net>
	<20100423182933.0df45b53@mschwide.boeblingen.de.ibm.com>
Message-ID: <1272325694.32741.16.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-23 at 18:29 +0200, Martin Schwidefsky wrote:
> > Questions:
> > 
> > - Isn't sched_clock() supposed to be extended to 64bit so
> >   that it practically never wraps?
> >   (old implementations use cnt32_to_63())
> 
> Yes, sched_clock() is supposed to return a monotonic timestamp.
>  
> > - What would be the effect on scheduling when sched_clock() wraps?
> 
> It would confuse the process accounting and the scheduling I guess.
> 

Are you sure about this? I'm pretty sure I've seen Ingo say multiple
times that sched_clock can wrap, and can be unstable. For instance
sched_clock is (was?) directly connected to the TSC on x86 ..

If it really can't wrap there must bunches of architectures that would
need to be fixed up.

Daniel
