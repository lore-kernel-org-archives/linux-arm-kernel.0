From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Nov 2015 18:29:28 +0000
Subject: [PATCH v4 1/6] arm64: ftrace: adjust callsite addresses examined
 by stack tracer
In-Reply-To: <20151102132043.060ef31d@gandalf.local.home>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
 <1446182741-31019-2-git-send-email-takahiro.akashi@linaro.org>
 <20151030111618.GA20030@arm.com>
 <20151102132043.060ef31d@gandalf.local.home>
Message-ID: <20151102182928.GJ2684@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 01:20:43PM -0500, Steven Rostedt wrote:
> On Fri, 30 Oct 2015 11:16:19 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > On Fri, Oct 30, 2015 at 02:25:36PM +0900, AKASHI Takahiro wrote:
> > > On arm64, no PC values returned by save_stack_trace() will match to LR
> > > values saved in stack frames on a stack after the following commit:
> > >     commit e306dfd06fcb ("ARM64: unwind: Fix PC calculation")
> > > As a result, the output from stack tracer will be messed up.
> > 
> > FWIW, we've decided to revert that patch for the moment. We're the only
> > architecture making that kind of adjustment, so we should fix that before
> > building on top of it.
> > 
> >
> 
> What is the status of this patch set. I'm currently pulling in last
> minute patches for 4.3 and should the ftrace patch in this series be
> applied? (I still need to review it too).

The revert Will mentioned is in v4.3 (see commit 9702970c7bd3e2d6), so
this series needs a respin to account for that.

Thanks,
Mark.
