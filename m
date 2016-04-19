From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Apr 2016 09:37:32 +0100
Subject: [PATCH] arm64: mm: remove the redundant code
In-Reply-To: <20160419071627.GA722@sha-win-210.asiapac.arm.com>
References: <1460944196-11780-1-git-send-email-shijie.huang@arm.com>
 <20160418130820.GD18257@e104818-lin.cambridge.arm.com>
 <20160419071627.GA722@sha-win-210.asiapac.arm.com>
Message-ID: <20160419083732.GA8482@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 03:16:29PM +0800, Huang Shijie wrote:
> On Mon, Apr 18, 2016 at 02:08:20PM +0100, Catalin Marinas wrote:
> > > @@ -212,10 +212,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> > >     tsk = current;
> > >     mm  = tsk->mm;
> > >
> > > -   /* Enable interrupts if they were enabled in the parent context. */
> > > -   if (interrupts_enabled(regs))
> > > -           local_irq_enable();
> >
> > We indeed don't have to re-enable interrupts here as they have been
> > enabled by the calling code in entry.S. But have you run this with
> > CONFIG_TRACE_IRQFLAGS enabled? I don't think there is any issue, just a
> > sanity check.
> I tested this patch with the CONFIG_TRACE_IRQFLAGS/CONFIG_PROVE_LOCKING/CONFIG_DEBUG_LOCKDEP
> enabled, in my Juno board, it works fine.
> 
> Also I find that with this patch, if we want to check the lockdep stat with:
>     #cat /proc/lockdep_stats
> 
> The "redundant hardirq ons" become 0. Without this patch, the redundant
> hardirq ons" is a big number, such as 123444.

Thanks for checking.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Will can pick this up for 4.7.

-- 
Catalin
