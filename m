From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 25 Jan 2010 11:35:41 +1100
Subject: [RFC,PATCH 3/7 v2] arm/versatile: use generic struct clk
In-Reply-To: <20100112162539.GH27771@n2100.arm.linux.org.uk>
References: <1263279511.160127.576969496193.0.gpush@pororo>
	<1263279511.161193.484965724912.3.gpush@pororo>
	<20100112162539.GH27771@n2100.arm.linux.org.uk>
Message-ID: <201001251135.41611.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> This doesn't make any sense.  What are you trying to do here?
> 
> The get/put operations go together as one logical set - that's why you
> get both if you're using clkdev, and why you're asked to implement both
> __clk_get() and __clk_put() in arch code to do whatever's necessary
> with the clock.

I'm assuming that clk_put will be specific to the implementation; fixed clocks 
probably won't need to do anything, but others may need a refcount, etc.

We don't have a struct clk to use clk_get on, so it remains a non-clock-
specific function.

We'll probably need the symmetry for some cases though, I think that a 
__clk_get(struct clk *) member of clk_operations would work for this, to be 
called by clk_get.

Cheers,


Jeremy
