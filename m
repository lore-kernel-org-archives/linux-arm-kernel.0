From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jan 2016 12:47:53 +0000
Subject: [PATCH 2/2] arm64: factor work_pending state machine to C
In-Reply-To: <20160106123011.GN6301@e104818-lin.cambridge.arm.com>
References: <20160105172106.GA7088@leverpostej>
 <1452015215-29506-2-git-send-email-mark.rutland@arm.com>
 <20160106123011.GN6301@e104818-lin.cambridge.arm.com>
Message-ID: <20160106124753.GI563@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 12:30:11PM +0000, Catalin Marinas wrote:
> On Tue, Jan 05, 2016 at 05:33:35PM +0000, Mark Rutland wrote:
> > Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> > state machine that can be difficult to reason about due to duplicated
> > code and a large number of branch targets.
> > 
> > This patch factors the common logic out into the existing
> > do_notify_resume function, converting the code to C in the process,
> > making the code more legible.
> > 
> > This patch tries to mirror the existing behaviour as closely as possible
> > while using the usual C control flow primitives. There should be no
> > functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chris Metcalf <cmetcalf@ezchip.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> This is definitely cleaner. The only downside is slightly more expensive
> ret_fast_syscall. I guess it's not noticeable (though we could do some
> quick benchmark like getpid in a loop). Anyway, I'm fine with the patch:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers!

While any additional overhead hasn't been noticeable, I'll try to get
some numbers out as part of the larger deasm testing/benchmarking.

Thanks,
Mark.
