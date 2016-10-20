From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 11:44:18 +0100
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20161020103707.GB3175@twins.programming.kicks-ass.net>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
 <20161020103707.GB3175@twins.programming.kicks-ass.net>
Message-ID: <20161020104417.GD10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 12:37:07PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 20, 2016 at 11:30:36AM +0200, Jan Glauber wrote:
> > Note:
> > I'm using perf_sw_context in difference to perf_invalid_context
> > (see WARN_ON in perf_pmu_register). Reason is that with perf_invalid_context
> > add() is never called and the counter results are shown as "unsupported" by
> > perf. With perf_sw_context everything works as expected.
> 
> What?! All the uncore PMUs use perf_invalid_context. What doesn't work
> for you?

I think there's general confusion over the use of invalid context.
Perhaps we could clear that up with:

#define perf_uncore_context	perf_invalid_context

and

s/perf_hw_context/perf_cpu_hw_context/

Mark.
