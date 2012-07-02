From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jul 2012 22:53:22 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FF1F331.3000001@codeaurora.org>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FF1F331.3000001@codeaurora.org>
Message-ID: <20120702215322.GB25234@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 08:14:57PM +0100, Stephen Boyd wrote:
> On 06/29/12 10:33, Will Deacon wrote:
> > This patch allows a timer-based delay implementation to be selected by
> > switching the delay routines over to use get_cycles, which is
> > implemented in terms of read_current_timer. This further allows us to
> > skip the loop calibration and have a consistent delay function in the
> > face of core frequency scaling.
> >
> > To avoid the pain of dealing with memory-mapped counters, this
> > implementation uses the co-processor interface to the architected timers
> > when they are available. The previous loop-based implementation is
> > kept around for CPUs without the architected timers and we retain both
> > the maximum delay (2ms) and the corresponding conversion factors for
> > determining the number of loops required for a given interval. Since the
> > indirection of the timer routines will only work when called from C,
> > the sa1100 sleep routines are modified to branch to the loop-based delay
> > functions directly.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for the reviews Stephen. I'll stick this in the patch system this
week.

Cheers,

Will
