From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 20 Oct 2016 13:30:05 +0200
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20161020112351.GC13708@hardcore>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
 <20161020103707.GB3175@twins.programming.kicks-ass.net>
 <20161020112351.GC13708@hardcore>
Message-ID: <20161020113005.GV3102@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 01:23:51PM +0200, Jan Glauber wrote:
> On Thu, Oct 20, 2016 at 12:37:07PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 20, 2016 at 11:30:36AM +0200, Jan Glauber wrote:
> > > Note:
> > > I'm using perf_sw_context in difference to perf_invalid_context
> > > (see WARN_ON in perf_pmu_register). Reason is that with perf_invalid_context
> > > add() is never called and the counter results are shown as "unsupported" by
> > > perf. With perf_sw_context everything works as expected.
> > 
> > What?! All the uncore PMUs use perf_invalid_context. What doesn't work
> > for you?
> 
> OK, so using perf_invalid_context and "-a" seems to work.
> 
> But I must say that I hate that from a user perspective. The user needs to know about
> the type of PMU behind the event and then provide "-a" or get a "<not supported"
> as counter value?

This really boils down to the fact that users really had better know
what they're on about.

There's only so much you can let clueless people do.

The fact is, they already _manually_ select your (uncore) PMU, so they
had then better also know what its limitations are.
