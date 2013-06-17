From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 17:07:21 +0200
Subject: [PATCH] ARM: mm: cpu_fa526_do_idle: remove WFI
In-Reply-To: <20130617143021.GI2718@n2100.arm.linux.org.uk>
References: <1371476360-8751-1-git-send-email-jonas.jensen@gmail.com>
 <5020304.hteFFmWh1u@wuerfel> <20130617143021.GI2718@n2100.arm.linux.org.uk>
Message-ID: <2819561.Rn435lDYbW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013 15:30:21 Russell King - ARM Linux wrote:
> > > diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
> > > index d217e97..85280b1 100644
> > > --- a/arch/arm/mm/proc-fa526.S
> > > +++ b/arch/arm/mm/proc-fa526.S
> > > @@ -81,9 +81,7 @@ ENDPROC(cpu_fa526_reset)
> > >   */
> > >     .align  4
> > >  ENTRY(cpu_fa526_do_idle)
> > > -   mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
> > > -   mov     pc, lr
> > > -
> > > +   nop
> 
> It replaces the WFI and return with a pure nop, so we will fall through
> to cpu_fa526_dcache_clean_area().  Do we really want to clean a random
> D cache entry depending on what r0 happened to hold at this point?  I
> think not...

Right, I should have actually read the change...

	Arnd
