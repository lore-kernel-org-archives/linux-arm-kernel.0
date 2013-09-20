From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Sep 2013 15:00:18 +0100
Subject: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
In-Reply-To: <20130920121652.GA7630@mtj.dyndns.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
Message-ID: <20130920140018.GP25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 07:16:52AM -0500, Tejun Heo wrote:
> On Fri, Sep 20, 2013 at 12:11:38AM +0100, Russell King wrote:
> > The correct way for a driver to specify the coherent DMA mask is
> > not to directly access the field in the struct device, but to use
> > dma_set_coherent_mask().  Only arch and bus code should access this
> > member directly.
> > 
> > Convert all direct write accesses to using the correct API.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> The patch is pretty widely spread.  I don't mind how it gets routed
> but what's the plan?

The plan is... I'm going to try and avoid going through the hell of
re-posting this patch series to all the recipients another time...
(It's taken some 17 hours and lots of hand holding to get this patch
set out without exim jumping off a cliff into deep OOM - soo deep that
even the OOM killer doesn't run and the CPU is 100% idle because
every single process stuck in an uninterruptible sleep waiting for
every other process to free some memory - ouch!)

I know that dealing with this patch set will be a problem due to how
widespread this is, but much of the driver level changes come down to
depending on a couple of patches.  One solution would be if I published
a branch with just the dependencies in, which subsystem maintainers
could pull, and then apply the appropriate patches on top.

Another would be if subsystem maintainers are happy that I carry them,
I can add the acks, and then later on towards the end of the cycle,
provide a branch subsystem maintainers could pull.

Or... if you can think of something easier...
