From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 May 2016 14:46:42 +0100
Subject: [PATCH] perf/core / arm_pmu: special-case hetereogeneous CPUs
In-Reply-To: <20160504134419.GA15849@leverpostej>
References: <20160425175837.GB3141@leverpostej>
 <20160425190334.GK3448@twins.programming.kicks-ass.net>
 <20160426103346.GA20836@leverpostej>
 <20160504134419.GA15849@leverpostej>
Message-ID: <20160504134641.GB31744@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 02:44:20PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Tue, Apr 26, 2016 at 11:33:46AM +0100, Mark Rutland wrote:
> > On Mon, Apr 25, 2016 at 09:03:34PM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 25, 2016 at 06:58:37PM +0100, Mark Rutland wrote:
> > > > Hi,
> > > > 
> > > > When booting an arm64 defconfig linux-next (next-20160422) on an ARM
> > > > Juno system, I hit a WARN_ON_ONCE in perf_pmu_register (see backtrace at
> > > > the end of this email).
> > > > 
> > > > This was introduced by commit 26657848502b7847 ("perf/core: Verify we
> > > > have a single perf_hw_context PMU") where we forcefully prevent multiple
> > > > PMUs from sharing perf_hw_context (with a warning), and force additional
> > > > PMUs to use perf_invalid_context.
> > 
> > > > Are you happy to revert 26657848502b787 for the timebeing? Or to somehow
> > > > predicate the check such that it doesn't adversely affect those HW PMUs?
> > > 
> > > I'm happy with a chicken bit for now, its already found two real issues,
> > > so I'd like to keep it.
> > 
> > Ok, how about the below? (based on next-20160422).
> 
> Peter, any thoughts?
> 
> This is still an issue for us in next-20160504 (to which the patch still
> applies).
> 
> Will, I assume that you're ok with the change to drivers/perf/arm_pmu.c.

Yes, they're pretty straighforward.

Will
