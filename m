From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 10 Dec 2010 21:23:01 -0500 (EST)
Subject: [PATCH] sched: Fix the irqtime code to deal with u64 wraps
In-Reply-To: <1292013506.13513.78.camel@laptop>
References: <1292013506.13513.78.camel@laptop>
Message-ID: <alpine.LFD.2.00.1012102116540.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Dec 2010, Peter Zijlstra wrote:

> OK, so here's the latest version, using fancy __this_cpu thingies.
> 
> I started a new thread since the old one was quite unwieldy.
> 
> Now, admittedly this patch is a tad large, esp for -rc5. So either we
> need lots of Reviewed-by and such or I need to shrink this patch
> somehow.
> 
> 
> ---
> Subject: sched: Fix the irqtime code to deal with u64 wraps
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Thu Dec 09 14:15:34 CET 2010
> 
> ARM systems have a 32bit sched_clock() [ which needs to be fixed ],
> but this exposed a bug in the irq_time code as well, it doesn't deal
> with wraps at all.
[...]

That would be more close to reality if you stated "Some ARM systems have 
a 32bit sched_clock() [" above.  Most ARM systems in use today have a 
sched_clock() with more than 32 bits, like 55 bits or so.


Nicolas
