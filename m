From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 11:10:51 +0100
Subject: [PATCH 6/8] arm: perf: fold percpu_pmu into pmu_hw_events
In-Reply-To: <5446D893.6020708@codeaurora.org>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-7-git-send-email-mark.rutland@arm.com>
 <5446D893.6020708@codeaurora.org>
Message-ID: <20141022101051.GC22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 11:05:07PM +0100, Stephen Boyd wrote:
> On 10/21/2014 06:11 AM, Mark Rutland wrote:
> > Currently the percpu_pmu pointers used as percpu_irq dev_id values are
> > defined separately from the other per-cpu accounting data, which make
> > dynamically allocating the data (as will be required for systems with
> > heterogeneous CPUs) difficult.
> >
> > This patch moves the percpu_pmu pointers into pmu_hw_events (which is
> > itself allocated per cpu), which will allow for easier dynamic
> > allocation. Both percpu and regular irqs are requested using percpu_pmu
> > pointers as tokens, freeing us from having to know whether an irq is
> > percpu within the handler, and thus avoiding a radix tree lookup on the
> > handler path.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Works on Krait with percpu interrupts.

Thanks for testing!

Mark.
