From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Nov 2013 12:01:25 +0000
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131119092741.GC28642@pengutronix.de>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <20131111090810.GI14892@pengutronix.de>
 <20131111112554.GE28302@mudshark.cambridge.arm.com>
 <20131119092741.GC28642@pengutronix.de>
Message-ID: <20131119120125.GE11778@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 09:27:41AM +0000, Uwe Kleine-K?nig wrote:
> On Mon, Nov 11, 2013 at 11:25:54AM +0000, Will Deacon wrote:
> > I see gas is being as helpful as ever. Something like the (untested) patch
> > below should fix the issue.
> > 
> > Will
> > 
> > --->8
> > 
> > diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> > index e0c68d5bb7dc..52886b89706c 100644
> > --- a/arch/arm/lib/bitops.h
> > +++ b/arch/arm/lib/bitops.h
> > @@ -10,7 +10,7 @@ UNWIND(       .fnstart        )
> >         and     r3, r0, #31             @ Get bit offset
> >         mov     r0, r0, lsr #5
> >         add     r1, r1, r0, lsl #2      @ Get word offset
> > -#if __LINUX_ARM_ARCH__ >= 7
> > +#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
> >         .arch_extension mp
> >         ALT_SMP(W(pldw) [r1])
> >         ALT_UP(W(nop))
> > 
> It does fix compilation and I booted successfully on my efm32-tree +
> next-20131119 + this patch + the patch for the be signal stuff.

Ok, great. Mind if I add your tested-by before I put it in the patch system?

Cheers,

Will
