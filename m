From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 2 Oct 2012 16:03:33 +0100
Subject: [PATCH v2 RESEND 2/2] ARM: local timers: add timer support using
 IO mapped register
In-Reply-To: <20121002134444.GB28600@e102568-lin.cambridge.arm.com>
References: <1347694914-1457-1-git-send-email-rvaswani@codeaurora.org>
 <1347694914-1457-2-git-send-email-rvaswani@codeaurora.org>
 <5062013F.8050507@codeaurora.org>
 <20120928122858.GD9472@e106331-lin.cambridge.arm.com>
 <20120928155746.GB2253@linaro.org>
 <20120928171549.GA29991@e102568-lin.cambridge.arm.com>
 <20121002112704.GA2410@linaro.org>
 <20121002134444.GB28600@e102568-lin.cambridge.arm.com>
Message-ID: <20121002150333.GC2108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 02:44:44PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 02, 2012 at 12:27:04PM +0100, Dave Martin wrote:
> > On Fri, Sep 28, 2012 at 06:15:53PM +0100, Lorenzo Pieralisi wrote:
> > > On Fri, Sep 28, 2012 at 04:57:46PM +0100, Dave Martin wrote:
> 
> [...]
> 
> > > There must be a common way for all devices to link to the topology, though.
> > > 
> > > The topology must be descriptive enough to cater for all required cases
> > > and that's what Mark with PMU and all of us are trying to come up with, a solid
> > > way to represent with DT the topology of current and future ARM systems.
> > > 
> > > First idea I implemented and related LAK posting:
> > > 
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080873.html
> > > 
> > > Are "cluster" nodes really needed or "cpu" nodes are enough ? I do not
> > > know, let's get this discussion started, that's all I need.
> > 
> > One thing which now occurs to me on this point it that if we want to describe
> > the CCI properly in the DT (yes) then we need a way to describe the mapping
> > between clusters and CCI slave ports.  Currently that knowledge just has to
> > be a hard-coded hack somewhere: it's not probeable at all.
> 
> That's definitely a good point. We can still define CCI ports as belonging
> to a range of CPUs, but that's a bit of a stretch IMHO.
> 
> > I'm not sure how we do that, or how we describe the cache topology, without
> > the clusters being explicit in the DT
> > 
> > ...unless you already have ideas ?
> 
> Either we define the cluster node explicitly or we can always see it as a
> collection of CPUs, ie phandles to "cpu" nodes. That's what the decision
> we have to make is all about. I think that describing it explicitly make
> sense, but we need to check all possible use cases to see if that's
> worthwhile.

How is the cache topology described today (forgive my laziness in not
answering this question for myself)?  The issues are somewhat similar.

I still have some misgivings about describing clusters in terms of sets of
CPUs.  For example, when we boot up a cluster, we have to set up ... the
cluster.  This is a distinct thing which we must set up in addition to
any of the actual CPUs.

There is a strict child/parent relationship between clusters and CPUs, so
a tree of nodes does seem the most natural description ... but I'm not
aware of all the background to this discussion.

Cheers
---Dave
