From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 30 Sep 2010 10:04:08 +0900
Subject: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <20100927222627.GH28588@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
	<e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
	<20100916143254.GC13563@erda.amd.com>
	<20100927200138.GG28588@console-pimps.org>
	<20100927220703.GV13563@erda.amd.com>
	<20100927222627.GH28588@console-pimps.org>
Message-ID: <20100930010407.GA18073@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 11:26:27PM +0100, Matt Fleming wrote:
> On Tue, Sep 28, 2010 at 12:07:03AM +0200, Robert Richter wrote:
> > On 27.09.10 16:01:38, Matt Fleming wrote:
> > > Well, ARM doesn't have names as strings for its pmus currently. What's
> > > more, ARM wouldn't use it; SH would be the only user of this function. I
> > > don't think this one makes sense to be a generic function.
> > 

Er, what? Yes it does. It has this silly id to string mapping thing that
is at present duplicated between the perf and the oprofile code for no
reason. Having a generic (albeit optional) perf_pmu_name() would allow
this to be cleaned up.

> > As the implementation of the function would be optional, why should we
> > make it architectural?
> 
> I don't see why we should pollute the perf namespace with a function
> that is only being used inside the SH oprofile code? There would be
> exactly one use of this function and I doubt the perf guys will want
> this function exposed. In it's current state, it really is no use to any
> architecture other than SH.
> 
This has nothing at all to do with the SH oprofile code and everything to
do with oprofile in general. This is the vary basis for the CPU model
matching in the oprofile userspace tools, it's string based by design.
Given that we're already seeing architetures double up their strings in
both places, this really wants a consensus and to be dealt with before
other architetures start getting the wrong idea.
