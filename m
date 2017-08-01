From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 1 Aug 2017 13:34:44 +0200
Subject: [PATCH] clocksource: arm_arch_timer: Fix mem frame loop
 initialization
In-Reply-To: <20170801111222.GC9347@leverpostej>
References: <20170731183728.61087-1-mka@chromium.org>
 <20170801111222.GC9347@leverpostej>
Message-ID: <20170801113444.GB1919@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 12:12:23PM +0100, Mark Rutland wrote:
> On Mon, Jul 31, 2017 at 11:37:28AM -0700, Matthias Kaehlcke wrote:
> > The loop to find the best memory frame in arch_timer_mem_acpi_init()
> > initializes the loop counter with itself ('i = i'), which is suspicious
> > in the first place and pointed out by clang. The loop condition is
> > 'i < timer_count' and a prior for loop exits when 'i' reaches
> > 'timer_count', therefore the second loop is never executed.
> > 
> > Initialize the loop counter with 0 to iterate over all timers, which
> > supposedly was the intention before the typo monster attacked.
> > 
> > Fixes: c2743a36765d3 ("clocksource: arm_arch_timer: add GTDT support for memory-mapped timer")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Ard also spotted this issue [1], along with another issue we still need
> to solve. In the mean time it would be nice to have this fixed, so:
> 
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Daniel, Thomas,
> 
> Could one of you please pick this up as a fix, with the above tags?


Hi Mark,

picked as a fix with the above tags.

Thanks.

  -- Daniel
