From: frank.rowand@am.sony.com (Frank Rowand)
Date: Tue, 28 Jun 2011 16:08:05 -0700
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <20110625132112.GH23234@n2100.arm.linux.org.uk>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>
Message-ID: <4E0A5ED5.8010207@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/11 06:21, Russell King - ARM Linux wrote:
> I've just been looking at the IRQS off tracer for the first time.  I'm
> getting output such as:

< snip >

> So, from what I can see, the irqsoff tracing support is next to useless,
> and given that, anyone got a good reason why I should care about its
> hooks?  If I should care about them, it really needs to be fixed so it
> actually provides useful information.

Here are my experiences as a data point that I hope can be useful...

Having irqsoff instrumentation has been crucial for my work.

Unfortunately I don't have experience with the current mainline
implementation. 

I started using irqsoff measurements in 2.6.24 plus the RT_PREEMPT
patch 2.6.24-rt1.  I found the overhead of the tools at that time
to be larger than desired for my purposes.  So I took the concepts
and framework from the RT_PREEMPT patch 2.6.24-rt1 and wrote a
more light weight (but much less user friendly and much less
mainline acceptable) version of irqsoff and preempt off measurement
tools.

The team that I wrote the tools for found enough value in them
to port them forward to 2.6.29 plus the RT_PREEMPT patches
when 2.6.29 arrived.  That team is now considering moving the
tools forward to 2.6.35 plus the RT_PREEMPT patches.

To sum up, the RT_PREEMPT irqsoff instrumentation that eventually
evolved into what is in mainline today had too much overhead for
__my purposes__.  But my kernel development teams and product
development teams have derived found similar (but lower overhead)
instrumentation to be critical for their tuning needs.

If Todd Poyner helps clean things up (as he offered in an earlier
reply), maybe I'll be able to find some time to help him out (not
sure how much I can promise to squeeze into my schedule yet).

-Frank Rowand
Sony Network Entertainment
