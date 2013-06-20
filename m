From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 10:11:37 +0100
Subject: [PATCH] perf: arm64: Record the user-mode PC in the call chain.
In-Reply-To: <20130620083327.GA5288@gmail.com>
References: <20130620030713.GA27428@mozilla.com>
 <20130620083327.GA5288@gmail.com>
Message-ID: <20130620091136.GC2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 09:33:28AM +0100, Ingo Molnar wrote:
> 
> * Jed Davis <jld@mozilla.com> wrote:
> 
> > With this change, we no longer lose the innermost entry in the user-mode
> > part of the call chain.  See also the x86 port, which includes the ip,
> > and the corresponding change in arch/arm.
> > 
> > Signed-off-by: Jed Davis <jld@mozilla.com>
> > ---
> >  arch/arm64/kernel/perf_event.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 1e49e5eb..9ba33c4 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -1336,6 +1336,7 @@ void perf_callchain_user(struct perf_callchain_entry *entry,
> >  		return;
> >  	}
> >  
> > +	perf_callchain_store(entry, regs->pc);
> >  	tail = (struct frame_tail __user *)regs->regs[29];
> >  
> >  	while (entry->nr < PERF_MAX_STACK_DEPTH &&
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> I suspect this goes to v3.10 via the ARM64 tree?

Yup, we'll take this via the arm64 tree, thanks.

Catalin, you can add:

	Acked-by: Will Deacon <will.deacon@arm.com>

to this.

Cheers,

Will
