From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2016 16:17:49 +0100
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20161020112351.GC13708@hardcore>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
 <20161020103707.GB3175@twins.programming.kicks-ass.net>
 <20161020112351.GC13708@hardcore>
Message-ID: <20161028151749.GG14402@arm.com>
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

Sure, but in the interest of getting *something* merged, can we start
off using perf_invalid_context and then have the discussion about whether
or not this can be extended later on, please? If your PMU is a shared
resource amongst CPUs, it maybe that all you want is a better error
message from the perf tool (but again, this can come later!).

Will
