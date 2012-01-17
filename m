From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 14:18:50 +0000
Subject: [PATCH] ARM: proc-v7: remove harvard cache stuff
In-Reply-To: <20120105094857.GA21121@arm.com>
References: <20120103175814.GG22876@arm.com>
 <1325745462-6560-1-git-send-email-shawn.guo@linaro.org>
 <20120105094857.GA21121@arm.com>
Message-ID: <20120117141846.GA23404@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 09:48:58AM +0000, Catalin Marinas wrote:
> On Thu, Jan 05, 2012 at 06:37:42AM +0000, Shawn Guo wrote:
> > The harvard cache related comment and code in proc-v7.S were copied
> > from proc-v6.S by mistake, so let's remove them.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mm/proc-v7.S |    7 -------
> >  1 files changed, 0 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index e70a737..59a4077 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -271,10 +271,6 @@ ENDPROC(cpu_v7_do_resume)
> >   *	Initialise TLB, Caches, and MMU state ready to switch the MMU
> >   *	on.  Return in r0 the new CP15 C1 control register setting.
> >   *
> > - *	We automatically detect if we have a Harvard cache, and use the
> > - *	Harvard cache control instructions insead of the unified cache
> > - *	control instructions.
> > - *
> >   *	This should be able to cover all ARMv7 cores.
> >   *
> >   *	It is assumed that:
> > @@ -373,9 +369,6 @@ __v7_setup:
> >  #endif
> >  
> >  3:	mov	r10, #0
> > -#ifdef HARVARD_CACHE
> > -	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
> > -#endif
> 
> I thought we still need to invalidate the I-cache, maybe moving it
> higher up after the v7_flush_dcache_all call.

I agree. Although this does seem to be working without the invalidation,
this might just be because everything tends to be shiny when we boot up.

Is anybody planning to follow up on this patch? I can't see it in any of the
trees that I'm tracking.

Thanks,

Will
