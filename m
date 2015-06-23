From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 13:25:09 +0530
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
In-Reply-To: <20150623070651.GA3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux> <20150623070651.GA3245@x1>
Message-ID: <20150623075509.GF16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-06-15, 08:06, Lee Jones wrote:
> > [Adding Rob]
> 
> Rob is not the only DT Maintainer, there are many of them.  The DT
> list was CC'ed, which they are all part of.  Adding them all
> separately is not required IMO.

I didn't Cc him because you missed him, but because we have been
discussing opp-v2 bindings recently and this was somehow related to
that. :)

> > On 22-06-15, 16:43, Lee Jones wrote:
> > 
> > At least some description was required here on why you need additional
> > bindings are what are they.
> 
> Sure, I can do that.
> 
> > Over that, this patch should have been present before any other
> > patches using these bindings.
> 
> I've never heard that one before, but it's easy to re-order the set.

I don't know, but it seems obvious to me: Bindings first and then the
code.

> > > +Required properties:
> > > +-------------------
> > > +- compatible		: Supported values are:
> > > +				"st,stih407-cpufreq"
> > 
> > Nodes for virtual devices aren't allowed in DT.
> 
> Then why do Exynos, Spear, HREF and Snowball have CPUFreq nodes?
> 
> One rule for one ... ?

Not really, but I got a bit confused now with your reply.

So, what I meant when I wrote: "Nodes for virtual devices aren't
allowed in DT", was that we aren't supposed to do something like:

cpufreq {
 ...
}

in DT as cpufreq isn't a device here. A CPU is a device and that can
contain whatever property we feel is reasonable.

What SPEAr and Exyons did was putting something in the cpu-node. Not a
node for cpufreq device itself. Couldn't find HREF and snowball's
bindings though..

-- 
viresh
