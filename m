From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 15:45:57 +0100
Subject: [PATCH 0/8] arm: perf: cleanups and initial refactoring
In-Reply-To: <53B3FF1B.2090202@codeaurora.org>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
 <53B3FF1B.2090202@codeaurora.org>
Message-ID: <20140702144557.GE24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 01:46:19PM +0100, Christopher Covington wrote:
> Hi Mark,
> 
> On 07/01/2014 11:11 AM, Mark Rutland wrote:
> > While reorganising the ARM perf backend to provide support for
> > heterogeneous PMUs in big.LITTLE systems, I encountered a couple of
> > issues requiring some preparatory work in addition to some opportunities
> > for general cleanup in the backend. This series consists of those
> > initial cleanups.
> > 
> > Currently the event mapping code in the ARM perf backend requires
> > multi-dimensional tables to map from common event encodings to raw
> > hardware values, where empty slots must be initialised to non-zero
> > values. The current way of organising this results in very large support
> > files which we can simplify with some macro use to remove a few hundred
> > lines and make things more legible.
> > 
> > The PMU naming is somewhat of a mess, with most names not being
> > supported by the perf tool. Given that no-one has complained, it seems
> > that the PMUs are not being accessed by name in a perf context, and we
> > can fix these to be consistent and usable with current tools. We update
> > the OProfile name mangling to ensure that OProfile (which accesses the
> > PMUs in its own namespace) are not adversely affected.
> > 
> > To prepare for reorganisation of the PMU probing code, new
> > platform_device_id values are added to allow ARMv6, ARMv7, and XScale
> > PMU platform_devices to be distinguished.
> 
> I ran Vince Weaver's perf events test suite [1] against a kernel with these
> patches applied on an 8074 Dragonboard [2] and didn't see any regressions. The
> patches also look good to me.
> 
> Tested-by: Christopher Covington <cov@codeaurora.org>

Thanks for testing, Christopher!

Will
