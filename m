From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 19:18:37 +0100
Subject: [PATCH 5/6] ARM: Don't set TLB ops broadcasting on UP ARMv7
In-Reply-To: <20100902181317.GV11597@atomide.com>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902162220.GO11597@atomide.com>
	<20100902165756.GV26319@n2100.arm.linux.org.uk>
	<20100902172133.GT11597@atomide.com>
	<20100902180153.GY26319@n2100.arm.linux.org.uk>
	<20100902181317.GV11597@atomide.com>
Message-ID: <20100902181837.GZ26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 11:13:17AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:54]:
> > On Thu, Sep 02, 2010 at 10:21:33AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 09:50]:
> > > > On Thu, Sep 02, 2010 at 09:22:20AM -0700, Tony Lindgren wrote:
> > > > > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > > > > index 07fc660..51a063d 100644
> > > > > --- a/arch/arm/mm/proc-v7.S
> > > > > +++ b/arch/arm/mm/proc-v7.S
> > > > > @@ -191,7 +191,8 @@ __v7_setup:
> > > > >  	UP(mov	r0, #(1 << 6))			@ fake it for UP
> > > > 
> > > > If it's UP, we set r0 to 1 << 6, which...
> > > > 
> > > > >  	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
> > > > 
> > > > means this test produces a non-zero result.
> > > > 
> > > > >  	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
> > > > > -	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
> > > > 
> > > > And therefore these instructions will not be executed.
> > > 
> > > AFAIK these bits are different for Cortex-A8 and A9, bit 6 is IBE on A8.
> > 
> > So what?
> 
> Ah right, sorry I should have looked more carefully. You're right, this patch
> is no longer needed either.

Thanks - I was wondering whether I was missing something.
